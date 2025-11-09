import 'package:flutter/material.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';

import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/activity_log_section.dart';
import '../widgets/contract_description_section.dart';
import '../widgets/contract_detail_section.dart';
import '../widgets/deliver_contract_dialog.dart';
import '../widgets/feedback_dialog.dart';

class ContractDetailScreen extends StatelessWidget {
  final String status; // Status parameter from navigation
  final String? contractId; // Optional contract ID
  final String? name; // Optional name
  final String? jobTitle; // Optional job title

  const ContractDetailScreen({
    super.key,
    this.status = 'Active', // Default to Active
    this.contractId,
    this.name,
    this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray900 : JAppColors.white,
      appBar: JAppbar(
        showBackArrow: false,
        title: Text(
          _getAppBarTitle(status),
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 18.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: (){
          Navigator.pop(context);
        },      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Banner (for non-active contracts)
              if (status.toLowerCase() != 'active') ...[
                _buildStatusBanner(status, isDark),
                const SizedBox(height: 16),
              ],

              // Job Title
              Text(
                jobTitle ?? 'Architects Construction Specialist',
                style: AppTextStyle.dmSans(
                  fontSize: 24.0,
                  weight: FontWeight.w700,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
              const SizedBox(height: 16),

              // Job Description
              ContractDescription(isDark: isDark),
              const SizedBox(height: 24),

              // Responsibilities Section
              _buildSection(
                title: 'Responsibilities:',
                items: [
                  'Provide technical guidance on architectural designs, construction materials, and project execution.',
                  'Collaborate with construction teams, engineers, and contractors to ensure project specifications are met.',
                  'Review and troubleshoot construction challenges, proposing effective solutions.',
                  'Assist clients in project planning, design selections, and material recommendations.',
                  'Ensure compliance with building codes, safety regulations, and industry standards.',
                  'Document and track project progress, issues, and resolutions.',
                  'Stay updated on construction trends, sustainability practices, and emerging technologies.',
                  'Provide training and guidance to construction teams and junior professionals on best practices.',
                ],
                isDark: isDark,
              ),
              const SizedBox(height: 24),

              // Requirements Section
              _buildSection(
                title: 'Requirements:',
                items: [
                  'Bachelor\'s degree in Architecture, Civil Engineering, or a related field; or equivalent work experience.',
                  'Proven experience as an Architect, Construction Specialist, or in a similar role.',
                  'Strong knowledge of construction techniques, building materials, and structural integrity.',
                  'Familiarity with CAD software, architectural design principles, and construction blueprints.',
                  'Excellent communication skills, both verbal and written, to interact with teams and clients effectively.',
                  'A customer-focused attitude with a commitment to high-quality service.',
                  'Ability to work independently and collaboratively in a fast-paced environment.',
                  'Strong problem-solving skills with keen attention to detail.',
                  'Familiarity with project management tools and remote collaboration techniques.',
                  'Certifications such as LEED, PMP, or relevant industry certifications are a plus.',
                ],
                isDark: isDark,
              ),
              const SizedBox(height: 24),

              // Profile Card
              _buildProfileCard(isDark),
              const SizedBox(height: 24),

              // Contract Details Section
              ContractDetailsSection(isDark: isDark),
              const SizedBox(height: 24),

              // Activity Log Section
              ActivityLogSection(isDark: isDark),
              const SizedBox(height: 24),

              // Action Buttons based on status
              _buildActionButtons(context, status, isDark),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Active Contract';
      case 'completed':
        return 'Completed Contract';
      case 'paused':
        return 'Paused Contract';
      case 'cancelled':
        return 'Cancelled Contract';
      default:
        return 'Contract Details';
    }
  }

  Widget _buildStatusBanner(String status, bool isDark) {
    final statusInfo = _getStatusBannerInfo(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusInfo['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusInfo['color'].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            statusInfo['icon'],
            color: statusInfo['color'],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusInfo['title'],
                  style: AppTextStyle.dmSans(
                    fontSize: 15.0,
                    color: statusInfo['color'],
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statusInfo['message'],
                  style: AppTextStyle.dmSans(
                    fontSize: 13.0,
                    color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray700,
                    weight: FontWeight.w400,
                  ),
                ),
                // Show rating for completed contracts
                if (status.toLowerCase() == 'completed') ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildRatingStars(4.5), // Example rating
                      const SizedBox(width: 8),
                      Text(
                        '4.5/5.0',
                        style: AppTextStyle.dmSans(
                          fontSize: 13.0,
                          color: statusInfo['color'],
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  Map<String, dynamic> _getStatusBannerInfo(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return {
          'color': JAppColors.success600,
          'icon': Icons.check_circle,
          'title': 'Contract Completed Successfully',
          'message': 'This contract has been completed and the work has been delivered.',
        };
      case 'paused':
        return {
          'color': Colors.orange,
          'icon': Icons.pause_circle,
          'title': 'Contract Temporarily Paused',
          'message': 'This contract is on hold. You can resume it when ready.',
        };
      case 'cancelled':
        return {
          'color': JAppColors.error600,
          'icon': Icons.cancel,
          'title': 'Contract Cancelled',
          'message': 'This contract has been cancelled and is no longer active.',
        };
      default:
        return {
          'color': JAppColors.lightGray600,
          'icon': Icons.info,
          'title': 'Contract Status',
          'message': 'Check the details below for more information.',
        };
    }
  }

  Widget _buildActionButtons(BuildContext context, String status, bool isDark) {
    final statusLower = status.toLowerCase();

    // Active contracts - Show Submit Work and Send Message
    if (statusLower == 'active') {
      return Column(
        children: [
          // Submit Work Button
          MainButton(
            btn_title: 'Submit Work',
            onTap: () {
              // Show Deliver Contract Dialog
              showDialog(
                context: context,
                builder: (context) => DeliverContractDialog(
                  isDark: isDark,
                ),
              ).then((result) {
                if (result != null) {
                  // Handle the result
                  print('File: ${result['file']?.name}');
                  print('Message: ${result['message']}');

                  // Show feedback dialog after successful delivery
                  _showFeedbackDialog(context, isDark);
                }
              });
            },
            prefixIcon: Icons.upload_file,
            prefixIconSize: 20,
            buttonType: MainButtonType.primary,
            btn_color: JAppColors.primary,
            title_color: Colors.white,
            text_fontweight: FontWeight.w600,
            height: 52,
            width: double.infinity,
          ),
          const SizedBox(height: 12),

          // Send a Message Button
          MainButton(
            btn_title: 'Send a Message',
            onTap: () {
              AppRouter.router.push('/chatScreen');
            },
            prefixIcon: Icons.message,
            prefixIconSize: 20,
            buttonType: MainButtonType.outlined,
            btn_border_color: JAppColors.primary,
            title_color: JAppColors.primary,
            text_fontweight: FontWeight.w600,
            height: 52,
            width: double.infinity,
          ),
        ],
      );
    }

    // Completed contracts - Show View Report and Leave Feedback
    if (statusLower == 'completed') {
      return Column(
        children: [
          // View Completion Report Button
          MainButton(
            btn_title: 'View Completion Report',
            onTap: () {
              // Navigate to completion report or show details
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Icon(Icons.check_circle, color: JAppColors.success600),
                      const SizedBox(width: 8),
                      Text('Completion Report'),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contract completed successfully!'),
                      const SizedBox(height: 12),
                      Text('Completion Date: June 30, 2024'),
                      Text('Rating: ⭐⭐⭐⭐⭐ 5.0'),
                      Text('Payment Status: Completed'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
            prefixIcon: Icons.description,
            prefixIconSize: 20,
            buttonType: MainButtonType.primary,
            btn_color: JAppColors.success600,
            title_color: Colors.white,
            text_fontweight: FontWeight.w600,
            height: 52,
            width: double.infinity,
          ),
          const SizedBox(height: 12),

          // Leave Feedback Button
          MainButton(
            btn_title: 'Leave Feedback',
            onTap: () {
              _showFeedbackDialog(context, isDark);
            },
            prefixIcon: Icons.star,
            prefixIconSize: 20,
            buttonType: MainButtonType.outlined,
            btn_border_color: JAppColors.success600,
            title_color: JAppColors.success600,
            text_fontweight: FontWeight.w600,
            height: 52,
            width: double.infinity,
          ),
        ],
      );
    }

    // Paused contracts - Show information only (view-only)
    if (statusLower == 'paused') {
      return Column(
        children: [
          // Paused Status Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.pause_circle, color: Colors.orange, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contract Paused',
                        style: AppTextStyle.dmSans(
                          fontSize: 15.0,
                          color: Colors.orange.shade900,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'This contract has been temporarily paused by the client. You cannot submit work at this time.',
                        style: AppTextStyle.dmSans(
                          fontSize: 13.0,
                          color: Colors.orange.shade800,
                          weight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Contact Client Button (for inquiries only)
          MainButton(
            btn_title: 'Contact Client',
            onTap: () {
              AppRouter.router.push('/chatScreen');
            },
            prefixIcon: Icons.message,
            prefixIconSize: 20,
            buttonType: MainButtonType.outlined,
            btn_border_color: Colors.orange,
            title_color: Colors.orange,
            text_fontweight: FontWeight.w600,
            height: 52,
            width: double.infinity,
          ),
        ],
      );
    }

    // Cancelled contracts - Show information only (view-only)
    if (statusLower == 'cancelled') {
      return Column(
        children: [
          // Cancellation Details Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: JAppColors.error500,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: JAppColors.error200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.cancel, color: JAppColors.error600, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Contract Cancelled',
                        style: AppTextStyle.dmSans(
                          fontSize: 16.0,
                          color: JAppColors.error700,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Reason:', 'Project requirements changed', isDark),
                const SizedBox(height: 8),
                _buildInfoRow('Cancelled by:', 'Client', isDark),
                const SizedBox(height: 8),
                _buildInfoRow('Cancellation Date:', 'May 25, 2024', isDark),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 18, color: JAppColors.error700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Partial payment has been processed for completed work.',
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            color: JAppColors.error800,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Contact Support Button
          MainButton(
            btn_title: 'Contact Support',
            onTap: () {
              AppRouter.router.push('/chatScreen');
            },
            prefixIcon: Icons.support_agent,
            prefixIconSize: 20,
            buttonType: MainButtonType.outlined,
            btn_border_color: JAppColors.error600,
            title_color: JAppColors.error600,
            text_fontweight: FontWeight.w600,
            height: 52,
            width: double.infinity,
          ),
        ],
      );
    }

    // Default - No buttons for other statuses
    return const SizedBox.shrink();
  }
  void _showFeedbackDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => FeedbackDialog(
        isDark: isDark,
      ),
    ).then((result) {
      if (result != null) {
        // Handle feedback result
        print('Rating: ${result['rating']}');
        print('Likes: ${result['likes']}');
        print('Dislikes: ${result['dislikes']}');
        print('Review: ${result['review']}');

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thank you for your feedback!'),
            backgroundColor: JAppColors.success600,
          ),
        );
      }
    });
  }

  Widget _buildSection({
    required String title,
    required List<String> items,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, right: 12),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? JAppColors.darkGray400
                      : JAppColors.lightGray700,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: AppTextStyle.dmSans(
                    fontSize: 14.0,
                    color: isDark
                        ? JAppColors.darkGray300
                        : JAppColors.lightGray700,
                    height: 1.6,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildProfileCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray800 : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Profile Image
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(JImages.image),
                backgroundColor: JAppColors.lightGray300,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isDark ? JAppColors.darkGray800 : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Name and Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? 'Shehla Abbas',
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray900,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: JAppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'United States',
                      style: AppTextStyle.dmSans(
                        fontSize: 13.0,
                        color: isDark
                            ? JAppColors.darkGray400
                            : JAppColors.lightGray600,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: AppTextStyle.dmSans(
              fontSize: 13.0,
              color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray700,
              weight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.dmSans(
              fontSize: 13.0,
              color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray900,
              weight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}