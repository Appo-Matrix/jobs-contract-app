import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';

import '../../../../utils/common_widgets/appbar2.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/common_widgets/option_card.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.darkGray900 : Colors.white;
    final textColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: JText.back),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Specialization Section
                Text(
                  JText.verifyAccount,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray800,
                    fontSize: 24.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  JText.verifyAccountChoose,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray300
                        : JAppColors.darkGray500,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    Expanded(
                      child: OptionCard(
                        height: 140,
                        width: 140,
                        title: JText.email,
                        svgPath: JImages.emailsvg,
                        iconSize: 30,
                        onTap: () {
                          
                          AppRouter.router.push('/checkEmailScreen');
                          // Handle tap
                        },
                      ),
                    ),
                    SizedBox(
                      width: 19,
                    ),
                    Expanded(
                      child: OptionCard(
                        height: 140,
                        width: 140,
                        title: JText.phone,
                        svgPath: JImages.phonesvg,
                        iconSize: 30,
                        onTap: () {

                          AppRouter.router.push('/checkEmailScreen');

                          // Handle tap
                        },
                      ),
                    )
                  ],
                ),

                // Next Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
