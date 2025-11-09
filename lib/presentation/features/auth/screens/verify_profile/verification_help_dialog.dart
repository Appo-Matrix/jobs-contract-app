import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/common_widgets/main_button.dart';

class VerificationHelpDialog extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final List<String> bulletPoints;

  const VerificationHelpDialog({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.iconColor = JAppColors.primary,
    this.bulletPoints = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: isDark ? JAppColors.backGroundDarkCard : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                fontSize: 20.0,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                fontSize: 14.0,
                weight: FontWeight.w400,
              ),
            ),

            // Bullet Points
            if (bulletPoints.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? JAppColors.lightGray900.withOpacity(0.1)
                      : JAppColors.lightGray100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: bulletPoints.map((point) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 8),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: iconColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              point,
                              style: AppTextStyle.dmSans(
                                color: isDark
                                    ? JAppColors.darkGray200
                                    : JAppColors.lightGray700,
                                fontSize: 13.0,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Close Button
            SizedBox(
              width: double.infinity,
              child:         MainButton(
                btn_title: 'signIn',
                height: 46,
                btn_radius: 8,
                btn_color: iconColor,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: ()=>Navigator.pop(context),
              ),



              // ElevatedButton(
              //   onPressed: () => Navigator.pop(context),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: iconColor,
              //     padding: const EdgeInsets.symmetric(vertical: 14),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: Text(
              //     'Got it',
              //     style: AppTextStyle.dmSans(
              //       color: Colors.white,
              //       fontSize: 16.0,
              //       weight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}