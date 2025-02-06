import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class search_bar_widget extends StatelessWidget {
  final Widget prefixIcon;
  final Widget suffixFixIcon;
  final String title;
  final Color color;
  final Color textColor;
  final Color boarderRadiusColor;
  final double boarderRadius;

  const search_bar_widget({
    super.key,
    required this.isDark,
    required this.prefixIcon,
    required this.suffixFixIcon,
    required this.title,
    required this.color,
    required this.textColor,
    required this.boarderRadiusColor,
    required this.boarderRadius,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyle.dmSans(
        color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
        fontSize: JSizes.fontSizeMd,
        weight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: title,
        fillColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray200,
        filled: true,
        hintStyle: AppTextStyle.dmSans(
          color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray500,
          fontSize: JSizes.fontSizeMd,
          weight: FontWeight.w400,
        ),
        suffixIcon: suffixFixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: boarderRadiusColor,
            width: 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );
  }
}
