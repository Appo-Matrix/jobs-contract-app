import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TextTitleEducationWidget extends StatelessWidget {
  const TextTitleEducationWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.education,
    this.maxLines = 1, // Add maxLines with a default value of 1
  });

  final bool isDark;
  final String title;
  final String education;
  final int maxLines; // To control the max lines of the text

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark
                ? JAppColors.darkGray100
                : JAppColors.lightGray900.withValues(alpha: 0.8),
            fontSize: 16.0,
            weight: FontWeight.w600,
          ),
        ),

        SizedBox(height: JSizes.spaceBtwInputFields - 8), // Spacing

        Container(
          width: double.infinity,
          height: null, // Set height to null to allow it to expand
          decoration: BoxDecoration(
            color: Colors.transparent,  // Container's background color
            border: Border.all(
              color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800.withValues(alpha: 0.5),  // Border color
              width: 1,  // Border width
            ),
            borderRadius: BorderRadius.circular(8),  // Optional: rounded corners
          ),
          padding: EdgeInsets.symmetric(horizontal: 6),  // Padding inside the container
          child: Align(  // Align widget for precise alignment
            alignment: Alignment.centerLeft,  // Align text to the left and center vertically
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                education,
                maxLines: maxLines, // Use maxLines to limit the number of lines
                overflow: TextOverflow.ellipsis, // Show ellipsis when text overflows
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray900.withValues(alpha: 0.4),
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
