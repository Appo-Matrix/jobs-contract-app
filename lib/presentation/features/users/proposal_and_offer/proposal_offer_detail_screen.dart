import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/proposal_and_offer/widgets/contract_detail_row_widget.dart';
import 'package:job_contracts/presentation/features/users/proposal_and_offer/widgets/contract_details_card_widget.dart';
import 'package:job_contracts/presentation/features/users/proposal_and_offer/widgets/expandable_text_card_widget.dart';
import 'package:job_contracts/presentation/features/users/proposal_and_offer/widgets/job_card_widget.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';

class ProposalOfferDetailScreen extends StatefulWidget {
  final bool isReceivedOffer; // true = received offer, false = sent proposal
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

class _ProposalOfferDetailScreenState extends State<ProposalOfferDetailScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (widget.isReceivedOffer)
                _buildReceivedOfferContent(isDark)
              else
                _buildSentProposalContent(isDark),
            ],
          ),
        ),
      ),
    );
  }

  // Received Offer Content - Job Details + Apply Button
  Widget _buildReceivedOfferContent(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Job Description Section
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
          title: 'Electrician Needed',
          postedTime: 'Posted 3 days ago',
          location: 'United States',
          workType: 'Hybrid',
          salary: '\$20,000 - \$25,000',
          category: 'Residential',
          duration: '2 weeks',
          experience: '2+ Years',
          skills: ['Plumber', 'Electrical'],
        ),

        const SizedBox(height: 24),

        // Contract Details Section
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
            {'label': 'Contract Type', 'value': 'Fixed Price'},
            {'label': 'Project Budget', 'value': '\$20,000 - \$25,000'},
            {'label': 'Start Date', 'value': '20 May 2024'},
            {'label': 'End Date', 'value': '03 June 2024'},
            {'label': 'Payment Terms', 'value': 'Milestone-based'},
          ],
          projectDescription:
              'We are looking for an experienced electrician to work on a residential construction project. The project involves complete electrical wiring, installation of lighting fixtures, and electrical panel setup. Must have experience with residential electrical work and proper certifications.',
        ),

        const SizedBox(height: 24),

        // Apply Button
        MainButton(
          btn_title: 'Apply for this Job',
          btn_radius: 10,
          btn_color: JAppColors.primary,
          title_color: Colors.white,
          text_fontweight: FontWeight.w600,
          image_value: false,
          onTap: () {
            // Handle apply for job

            AppRouter.router.push('/jobDetailsPage');
          },
          isDark: isDark,
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSentProposalContent(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Proposal Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.orange.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: Colors.orange,
              ),
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

        // Contract Details Section
        Text(
          'Contract Details',
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
              width: 1,
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
                'Architects Construction for New Building',
                style: AppTextStyle.dmSans(
                  fontSize: 18.0,
                  weight: FontWeight.w700,
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Submitted on 13 May 2024',
                style: AppTextStyle.dmSans(
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                  color: isDark
                      ? JAppColors.darkGray100.withOpacity(0.6)
                      : JAppColors.darkGray800.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 16),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Proposed Rate',
                value: '\$45/hour',
              ),
              const SizedBox(height: 12),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Estimated Duration',
                value: '3-4 months',
              ),
              const SizedBox(height: 12),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Project Type',
                value: 'Commercial Construction',
              ),
              const SizedBox(height: 12),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Availability',
                value: 'Immediate',
              ),
              const SizedBox(height: 12),
              ContractDetailRowWidget(
                isDark: isDark,
                label: 'Payment Preference',
                value: 'Hourly',
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Cover Letter Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Cover Letter',
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w700,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),
        ),

        const SizedBox(height: 16),
        ExpandableTextCardWidget(
          isDark: isDark,
          text:
              '''Modern design in architecture and construction has revolutionized the way we perceive living spaces. By focusing on simplicity, functionality, and clean lines, modern homes create an environment that is both aesthetically pleasing and highly practical. Open layouts, large windows, and the integration of natural light are central elements, allowing spaces to feel more expansive and inviting. Materials such as glass, steel, and concrete are often used in combination with natural elements like wood and stone, creating a harmonious balance between industrial and organic textures. Smart home technology is increasingly incorporated into modern designs, enabling automated lighting, climate control, and security systems that enhance comfort and efficiency. Sustainability is another key aspect, with energy-efficient systems, solar panels, and eco-friendly materials becoming standard practice. Modern design also emphasizes minimalism, reducing clutter while maximizing the usability of each area. Interior spaces often feature neutral color palettes, sleek furniture, and functional storage solutions, promoting both elegance and convenience. Whether designing a family home, a commercial space, or a high-rise apartment, modern design principles ensure that every structure is visually appealing, structurally sound, and tailored to the needs of contemporary life. This approach represents the perfect blend of style, technology, and sustainability.)''',
          maxLines: 5, // initially show 5 lines
        ),

        const SizedBox(height: 24),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: MainButton(
                buttonType: MainButtonType.outlined,
                btn_title: 'Withdraw',
                btn_radius: 10,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                btn_border_color:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                image_value: false,
                onTap: () {
                  _showWithdrawDialog(isDark);

                  // Handle edit proposal
                },
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
                  // Handle edit proposal
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

  void _showWithdrawDialog(bool isDark) {

    ///todo
    ///may be api available user
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? JAppColors.darkGray700 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
            onPressed: () => Navigator.pop(context),
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
            onPressed: () {
              Navigator.pop(context);
              // Handle withdraw
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
}
