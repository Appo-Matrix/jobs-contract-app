import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/upgrade/widgets/membership_plan_card.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
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

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.membershipPlans ,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: BackCircle(
            isDark: isDark,
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Free Plan Card
              MembershipPlanCard(
                title: 'Free',
                subtitle: 'Free',
                isCurrentPlan: true,
                features: [
                  'Profile Creation',
                  'Limited Search',
                  'Job Applications',
                  'Basic Messaging',
                  'No Premium Features',
                ],
                buttonText: '',
                isPurple: false,
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Basic Plan Card
              MembershipPlanCard(
                title: 'Basic',
                subtitle: '\$45.10 per month*',
                features: [
                  'Higher visibility in search results',
                  'Priority for job opportunities',
                  'Statistics on profile performance',
                ],
                buttonText: 'Upgrade to Basic',
                isPurple: true,
                onTap: () {
                  // Handle basic plan upgrade
                },
              ),
              const SizedBox(height: 16),

              // Premium Plan Card
              MembershipPlanCard(
                title: 'Premium',
                subtitle: '\$45.10 per month*',
                features: [
                  'Higher visibility in search results',
                  'Priority for job opportunities',
                  'Statistics on profile performance',
                ],
                buttonText: 'Upgrade to Premium',
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