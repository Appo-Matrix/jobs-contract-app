import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class JTextTheme {
  JTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: JAppColors.lightGray900),  // Dark color for light theme
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: JAppColors.lightGray900),  // Slightly lighter dark color
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: JAppColors.lightGray900),  // Light dark color

    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: JAppColors.lightGray900),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: JAppColors.lightGray900),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: JAppColors.lightGray900),

    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: JAppColors.lightGray900),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: JAppColors.textDarkColor),
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: JAppColors.lightGray900.withOpacity(0.5)),

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: JAppColors.lightGray900),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: JAppColors.lightGray900.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: JAppColors.darkGray100),  // Light color for dark theme
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: JAppColors.darkGray100),
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: JAppColors.darkGray100),

    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: JAppColors.darkGray100),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: JAppColors.darkGray100),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: JAppColors.darkGray100),

    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: JAppColors.darkGray100),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: JAppColors.darkGray100),
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: JAppColors.darkGray100.withOpacity(0.5)),

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: JAppColors.darkGray100),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: JAppColors.darkGray100.withOpacity(0.5)),
  );
}
