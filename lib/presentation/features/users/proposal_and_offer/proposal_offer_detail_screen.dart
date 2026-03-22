import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/job_applications/job_application_response.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../providers/application_provider.dart';
import 'widgets/contract_detail_row_widget.dart';
import 'widgets/contract_details_card_widget.dart';
import 'widgets/expandable_text_card_widget.dart';
import 'widgets/job_card_widget.dart';

class ProposalOfferDetailScreen extends StatefulWidget {
  final bool isReceivedOffer;
  final String proposalId;

  const ProposalOfferDetailScreen({
    super.key,
    required this.isReceivedOffer,
    required this.proposalId,
  });

  @override
  State<ProposalOfferDetailScreen> createState() =>
      _ProposalOfferDetailScreenState();
}

class _ProposalOfferDetailScreenState
    extends State<ProposalOfferDetailScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ApplicationProvider>()
          .fetchApplicationById(widget.proposalId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),
        ),
        title: Text(
          widget.isReceivedOffer ? 'Offer Details' : 'Proposal Details',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 18,
              imageUrl: JImages.image,
            ),
          ),
        ],
      ),

      body: Consumer<ApplicationProvider>(
        builder: (context, provider, _) {

          // ── Loading ──
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Error ──
          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.dmSans(
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        provider.fetchApplicationById(widget.proposalId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // ✅ Find from already-loaded list first — avoids extra API call
          final MyJobApplication? app = _findApplication(provider);
          if (app == null) {
            return const Center(child: Text('No application data found'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  if (widget.isReceivedOffer)
                    _buildReceivedOfferContent(isDark, app, provider)
                  else
                    _buildSentProposalContent(isDark, app, provider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Find application from loaded list ──────────────────────────────────────
  MyJobApplication? _findApplication(ApplicationProvider provider) {
    final list = provider.myApplications?.data ?? [];
    if (list.isNotEmpty) {
      try {
        return list.firstWhere((a) => a.id == widget.proposalId);
      } catch (_) {}
    }
    return null;
  }

  // ── Received Offer ─────────────────────────────────────────────────────────
  Widget _buildReceivedOfferContent(
      bool isDark,
      MyJobApplication app,         // ✅ typed
      ApplicationProvider provider,
      ) {
    final ApplicationJob job = app.jobId; // ✅ typed — no map access

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Description',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        const SizedBox(height: 16),

        JobCardWidget(
          isDark: isDark,
          title: job.title,
          postedTime: _getTimeAgo(job.createdAt),
          location: job.jobLocation?.displayString ?? 'Location not available',
          workType: job.jobType,
          salary: job.salary.isNotEmpty ? job.salary : 'Not specified',
          category: job.jobCategory,
          duration: job.jobDuration,
          experience: job.experience,
          skills: job.skillsRequired.map((s) => s.name).toList(),
        ),

        const SizedBox(height: 24),

        Text(
          'Contract Details',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        const SizedBox(height: 16),

        ContractDetailsCardWidget(
          isDark: isDark,
          contractDetails: [
            {'label': 'Job Type',    'value': job.jobType},
            {'label': 'Duration',   'value': job.jobDuration},
            {'label': 'Experience', 'value': job.experience},
            {'label': 'Category',   'value': job.jobCategory},
            {
              'label': 'Salary',
              'value': job.salary.isNotEmpty ? job.salary : 'Not specified'
            },
          ],
          projectDescription: job.description,
        ),

        const SizedBox(height: 24),

        MainButton(
          btn_title: 'Apply for this Job',
          btn_radius: 10,
          btn_color: JAppColors.primary,
          title_color: Colors.white,
          text_fontweight: FontWeight.w600,
          image_value: false,
          onTap: () => context.push('/jobDetailsPage'),
          isDark: isDark,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // ── Sent Proposal ──────────────────────────────────────────────────────────
  Widget _buildSentProposalContent(
      bool isDark,
      MyJobApplication app,         // ✅ typed
      ApplicationProvider provider,
      ) {
    final ApplicationJob job = app.jobId; // ✅ typed

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ── Status Badge ───────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.schedule, size: 14, color: Colors.orange),
              const SizedBox(width: 6),
              Text(
                'Pending Review',
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Proposal Details',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? JAppColors.darkGray700 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? JAppColors.darkGray700 : Colors.grey[300]!,
            ),
            boxShadow: isDark
                ? []
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,                              // ✅ typed
                style: AppTextStyle.dmSans(
                  fontSize: 18.0,
                  weight: FontWeight.w700,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.darkGray800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Submitted on ${_formatDate(app.createdAt)}', // ✅ typed
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                  color: isDark
                      ? JAppColors.darkGray100.withOpacity(0.6)
                      : JAppColors.darkGray800.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 16),

              if (app.estimatedServiceCost != 0) ...[   // ✅ typed
                ContractDetailRowWidget(
                  isDark: isDark,
                  label: 'Estimated Cost',
                  value: '\$${app.estimatedServiceCost}',
                ),
                const SizedBox(height: 12),
              ],

              if (app.estimatedCompletionTime.isNotEmpty) ...[  // ✅ typed
                ContractDetailRowWidget(
                  isDark: isDark,
                  label: 'Estimated Duration',
                  value: app.estimatedCompletionTime,
                ),
                const SizedBox(height: 12),
              ],

              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Job Type',
                value: job.jobType.isNotEmpty ? job.jobType : 'Not specified',
              ),
              const SizedBox(height: 12),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Duration',
                value: job.jobDuration.isNotEmpty
                    ? job.jobDuration
                    : 'Not specified',
              ),
              const SizedBox(height: 12),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Experience Required',
                value: job.experience.isNotEmpty
                    ? job.experience
                    : 'Not specified',
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Cover Letter',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        const SizedBox(height: 16),

        ExpandableTextCardWidget(
          isDark: isDark,
          text: app.coverLetter.isNotEmpty    // ✅ typed
              ? app.coverLetter
              : 'No cover letter provided.',
          maxLines: 5,
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: MainButton(
                buttonType: MainButtonType.outlined,
                btn_title: 'Withdraw',
                btn_radius: 10,
                title_color: isDark
                    ? JAppColors.lightGray100
                    : JAppColors.darkGray800,
                text_fontweight: FontWeight.w600,
                btn_border_color: isDark
                    ? JAppColors.lightGray100
                    : JAppColors.darkGray800,
                image_value: false,
                onTap: () =>
                    _showWithdrawDialog(isDark, app.id, provider), // ✅ typed
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MainButton(
                btn_title: 'Edit Proposal',
                btn_radius: 10,
                btn_color: JAppColors.primary,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  // TODO: navigate to edit proposal screen
                },
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // ── Withdraw Dialog ────────────────────────────────────────────────────────
  void _showWithdrawDialog(
      bool isDark,
      String applicationId,
      ApplicationProvider provider,
      ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? JAppColors.darkGray700 : Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Withdraw Proposal',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        content: Text(
          'Are you sure you want to withdraw this proposal? This action cannot be undone.',
          style: AppTextStyle.dmSans(
            fontSize: 14.0,
            weight: FontWeight.w400,
            color: isDark
                ? JAppColors.darkGray100.withOpacity(0.8)
                : JAppColors.darkGray800.withOpacity(0.8),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w600,
                color: isDark
                    ? JAppColors.darkGray100.withOpacity(0.6)
                    : JAppColors.darkGray800.withOpacity(0.6),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await provider.deleteApplication(applicationId);
              if (mounted) Navigator.pop(context);
            },
            child: Text(
              'Withdraw',
              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _getTimeAgo(String createdAt) {
    try {
      final dt = DateTime.parse(createdAt);
      final diff = DateTime.now().difference(dt);
      if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} months ago';
      if (diff.inDays > 0) return 'Posted ${diff.inDays}d ago';
      if (diff.inHours > 0) return 'Posted ${diff.inHours}h ago';
      return 'Posted just now';
    } catch (_) {
      return '';
    }
  }

  String _formatDate(String createdAt) {
    try {
      final dt = DateTime.parse(createdAt);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return '';
    }
  }
}