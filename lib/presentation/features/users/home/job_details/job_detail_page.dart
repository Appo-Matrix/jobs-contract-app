import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/bottom_indicator.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),

                  Text(
                    JText.titleCoverLetter,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: JSizes.spaceBtwInputFields),

                  // Text input field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        maxLines: null,
                        style: AppTextStyle.dmSans(color: isDark ? JAppColors.lightGray100  : JAppColors.lightGray800, fontSize: 14.9, weight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: "Enter a description...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Submit button

                  MainButton(
                    btn_title: JText.submitCoverLetter,
                    btn_radius: 10,
                    btn_color: JAppColors.main,
                    btn_boarder_color: Color(0xff7030F1),
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom indicator bar

          SizedBox(
              width: 100,
              child: BottomIndicator(
                isDark: isDark,
                height: 6,
              )),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
