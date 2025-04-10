import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';


class ScrollableReportDescriptionBox extends StatelessWidget {
  final bool isDark;
  final TextEditingController controller;
  final String hintText;

  const ScrollableReportDescriptionBox({
    super.key,
    required this.isDark,
    required this.controller,
    this.hintText = 'What do you want to talk about?',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray500 : Colors.grey[300]!,
        ),
      ),
      child: Scrollbar(
        thumbVisibility: true,
        radius: const Radius.circular(10),
        thickness: 6,
        child: TextField(
          controller: controller,
          maxLines: null,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 16.0,
            weight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray300 : Colors.grey,
              fontSize: 16.0,
              weight: FontWeight.w400,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}