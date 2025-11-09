import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/upgrade/widgets/membership_plan_card.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class MembershipPlansScreen extends StatefulWidget {
  const MembershipPlansScreen({super.key});

  @override
  State<MembershipPlansScreen> createState() => _MembershipPlansScreenState();
}

class _MembershipPlansScreenState extends State<MembershipPlansScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    ///todo
    ///i think this screen will be removed
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'membershipPlans',
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
            children: [
              // Free Plan Card
              MembershipPlanCard(
                title: 'free',
                subtitle: 'free',
                isCurrentPlan: true,
                features: [
                  'profileCreation',
                  'limitedSearch',
                  'jobApplications',
                  'basicMessaging',
                  'noPremiumFeatures',
                ],
                buttonText: '',
                isPurple: false,
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Basic Plan Card
              MembershipPlanCard(
                title: 'basic',
                subtitle: '\$45.10 ${"perMonth".tr()}',
                features: [
                  'higherVisibility',
                  'priorityOpportunities',
                  'statisticsPerformance',
                ],
                buttonText: 'upgradeBasic',
                isPurple: true,
                onTap: () {
                  // Handle basic plan upgrade
                },
              ),
              const SizedBox(height: 16),

              // Premium Plan Card
              MembershipPlanCard(
                title: 'premium',
                subtitle: '\$45.10 ${"perMonth".tr()}',
                features: [
                  'higherVisibility',
                  'priorityOpportunities',
                  'statisticsPerformance',
                ],
                buttonText: 'upgradePremium',
                isPurple: false,
                onTap: () {
                  // Handle premium plan upgrade
                },
              ),
              const SizedBox(height: 30),

              // Page indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}