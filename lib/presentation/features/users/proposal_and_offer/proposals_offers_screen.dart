import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/job_applications/job_application_response.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../providers/application_provider.dart';
import 'widgets/proposal-item.dart';

class ProposalsOffersScreen extends StatefulWidget {
  const ProposalsOffersScreen({super.key});

  @override
  State<ProposalsOffersScreen> createState() => _ProposalsOffersScreenState();
}

class _ProposalsOffersScreenState extends State<ProposalsOffersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApplicationProvider>().fetchMyJobApplications();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title: Text(
          'Proposals & Offers',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // ── Tab Bar ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? JAppColors.darkGray700 : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: JAppColors.primary,
                unselectedLabelColor:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                labelStyle: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w600,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
                unselectedLabelStyle: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
                indicatorColor: JAppColors.primary,
                indicatorWeight: 2.5,
                tabs: const [
                  Tab(text: 'Received Offers'),
                  Tab(text: 'Sent Proposals'),
                ],
              ),
            ),
          ),

          // ── Tab Content ────────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReceivedOffers(isDark),
                _buildSentProposals(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Received Offers ────────────────────────────────────────────────────────
  Widget _buildReceivedOffers(bool isDark) {
    return Center(
      child: Text(
        'No offers received yet',
        style: AppTextStyle.dmSans(
          fontSize: 14.0,
          weight: FontWeight.w400,
          color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray500,
        ),
      ),
    );
  }

  // ── Sent Proposals ─────────────────────────────────────────────────────────
  Widget _buildSentProposals(bool isDark) {
    return Consumer<ApplicationProvider>(
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
                  onPressed: () => provider.fetchMyJobApplications(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // ✅ Typed as List<MyJobApplication> — no more dynamic map access
        final List<MyJobApplication> applications =
            provider.myApplications?.data ?? [];

        // ── Empty ──
        if (applications.isEmpty) {
          return Center(
            child: Text(
              'No proposals sent yet',
              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w400,
                color: isDark
                    ? JAppColors.darkGray300
                    : JAppColors.lightGray500,
              ),
            ),
          );
        }

        // ── Data ──
        return RefreshIndicator(
          onRefresh: () => provider.fetchMyJobApplications(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: applications.length,
            separatorBuilder: (_, __) => Divider(
              height: 32,
              color: isDark ? JAppColors.darkGray700 : Colors.grey[300],
            ),
            itemBuilder: (context, index) {
              final MyJobApplication app = applications[index];

              // ✅ Clean typed field access
              final String title = app.jobId.title;
              final String sentDate = _formatDate(app.createdAt);
              final String timeAgo = _getTimeAgo(app.createdAt);

              return ProposalItem(
                isDark: isDark,
                date: 'Sent on $sentDate',
                title: title,
                timeAgo: timeAgo,
                onTap: () {


                  context.push(
                    '/proposalOfferDetail',
                    extra: {
                      'isReceivedOffer': false,
                      'proposalId': app.id,
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _getTimeAgo(String createdAt) {
    try {
      final dt = DateTime.parse(createdAt);
      final diff = DateTime.now().difference(dt);
      if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} months ago';
      if (diff.inDays > 0) return '${diff.inDays}d ago';
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
      return 'Just now';
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