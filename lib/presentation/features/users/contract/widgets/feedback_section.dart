import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class FeedbackSection extends StatelessWidget {
  final String title;
  final List<String> options;

  const FeedbackSection({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.primary : JAppColors.primary,
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            return Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.transparent),
              ),
              label: Text(
                option,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray1000,
                  fontSize: 12.0,
                  weight: FontWeight.w400,
                ),
              ),
              backgroundColor:isDark ?JAppColors.backGroundDarkCard : JAppColors.darkGray800,
            );
          }).toList(),
        ),
      ],
    );
  }
}
