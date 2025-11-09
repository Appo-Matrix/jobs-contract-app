import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';
import 'widgets/support_option_widget.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'customerSupport',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 18.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Section with Icon
              _buildHeaderSection(isDark),

              SizedBox(height: JSizes.spaceBtwSections),

              // Welcome Message Card
              _buildWelcomeCard(isDark),

              SizedBox(height: JSizes.spaceBtwSections),

              // Support Options
              SupportOptionWidget(
                iconAsset: JImages.chatsupp,
                title: 'chatWithSupport',
                description: 'chatWithSupportDec',
                onTap: () {
                  AppRouter.router.push('/reportScreen');
                },
                isDark: isDark,
              ),

              SizedBox(height: JSizes.spaceBtwItems),

              SupportOptionWidget(
                iconAsset: JImages.viewreq,
                title: 'viewMyRequest',
                description: 'viewMyRequestDes',
                onTap: () {
                  AppRouter.router.push('/supportRequestsScreen');
                },
                isDark: isDark,
              ),

              SizedBox(height: JSizes.spaceBtwSections),

              // FAQ Section
              _buildFAQSection(isDark),

              SizedBox(height: JSizes.spaceBtwSections),

              // Availability Info Card
              _buildAvailabilityCard(isDark),

              SizedBox(height: JSizes.spaceBtwItems),

              // Response Time Info
              _buildResponseTimeInfo(isDark),

              SizedBox(height: JSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: JAppColors.primary.withOpacity(0.1),
          ),
          child: Icon(
            Icons.support_agent_rounded,
            size: 50,
            color: JAppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'How can we help you?',
          style: AppTextStyle.dmSans(
            fontSize: 22.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We\'re here to assist you with any questions',
          textAlign: TextAlign.center,
          style: AppTextStyle.dmSans(
            fontSize: 14.0,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            JAppColors.primary.withOpacity(0.1),
            JAppColors.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: JAppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: JAppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Choose an option below to get started with support',
              style: AppTextStyle.dmSans(
                fontSize: 13.0,
                weight: FontWeight.w500,
                color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? JAppColors.lightGray900.withOpacity(0.3)
            : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline_rounded,
                color: JAppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Quick Help',
                style: AppTextStyle.dmSans(
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildQuickHelpItem(
            'Average response time: 2-4 hours',
            Icons.access_time_rounded,
            isDark,
          ),
          const SizedBox(height: 8),
          _buildQuickHelpItem(
            'Available in multiple languages',
            Icons.language_rounded,
            isDark,
          ),
          const SizedBox(height: 8),
          _buildQuickHelpItem(
            'Track your support requests easily',
            Icons.track_changes_rounded,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelpItem(String text, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? JAppColors.lightGray400 : JAppColors.lightGray600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.dmSans(
              fontSize: 13.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.1),
            Colors.green.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We\'re Online!',
                  style: AppTextStyle.dmSans(
                    fontSize: 15.0,
                    weight: FontWeight.w600,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Our support team is available 24/7 to help you',
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    weight: FontWeight.w400,
                    color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseTimeInfo(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? JAppColors.lightGray900.withOpacity(0.2)
            : JAppColors.lightGray500,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 16,
            color: isDark ? JAppColors.lightGray400 : JAppColors.lightGray600,
          ),
          const SizedBox(width: 8),
          Text(
            'Typical response time: 2-4 hours during\n business days',
            textAlign: TextAlign.center,
            style: AppTextStyle.dmSans(
              fontSize: 12.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.lightGray400 : JAppColors.lightGray600,
            ),
          ),
        ],
      ),
    );
  }
}