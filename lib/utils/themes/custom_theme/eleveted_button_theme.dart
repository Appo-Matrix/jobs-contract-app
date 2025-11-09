import 'package:flutter/material.dart';
import '../../constants/colors.dart';  // If you have a separate file for colors
import '../../constants/sizes.dart';  // If you have a separate file for sizes

/// Light and dark elevated button themes
class JElevatedButtonTheme {
  JElevatedButtonTheme._();

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.white,  // White text on primary button
      backgroundColor: JAppColors.primary,  // Primary purple background
      disabledForegroundColor: JAppColors.lightGray500,  // Disabled text color
      disabledBackgroundColor: JAppColors.lightGray300,  // Disabled background
      side: const BorderSide(color: JAppColors.primary),  // Border matches background
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight),  // Vertical padding
      textStyle: const TextStyle(
        fontSize: 16,
        color: JAppColors.white,  // White text
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JSizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.white,  // White text on primary button
      backgroundColor: JAppColors.primary,  // Primary purple background
      disabledForegroundColor: JAppColors.darkGray500,  // Disabled text for dark mode
      disabledBackgroundColor: JAppColors.darkGray700,  // Disabled background for dark mode
      side: const BorderSide(color: JAppColors.primary),  // Border matches background
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight),  // Vertical padding
      textStyle: const TextStyle(
        fontSize: 16,
        color: JAppColors.white,  // White text
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JSizes.buttonRadius),
      ),
    ),
  );
}