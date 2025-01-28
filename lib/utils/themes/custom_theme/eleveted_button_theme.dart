import 'package:flutter/material.dart';
import '../../constants/colors.dart';  // If you have a separate file for colors
import '../../constants/sizes.dart';  // If you have a separate file for sizes

/// Light and dark elevated button themes
class JElevatedButtonTheme {
  JElevatedButtonTheme._();

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.lightGray100,  // Light foreground color (changed from default to lightGray100)
      backgroundColor: JAppColors.primary,     // Primary background color (changed to primary)
      disabledForegroundColor: JAppColors.lightGray500,  // Disabled foreground color (set to lightGray500)
      disabledBackgroundColor: JAppColors.lightGray300,   // Disabled background color (set to lightGray300)
      side: const BorderSide(color: JAppColors.primary),  // Border color (set to primary color)
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight),  // Vertical padding from JSizes
      textStyle: const TextStyle(
          fontSize: 16,  // Font size set to 16
          color: JAppColors.lightGray100, // Text color for light mode (changed to lightGray100)
          fontWeight: FontWeight.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.buttonRadius)),  // Button radius from JSizes
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.lightGray100,  // Light foreground color (changed to lightGray100 for dark theme)
      backgroundColor: JAppColors.primary,     // Primary background color (same as light theme)
      disabledForegroundColor: JAppColors.darkGray500,  // Disabled foreground color for dark mode (set to darkGray500)
      disabledBackgroundColor: JAppColors.darkGray300,   // Disabled background for dark mode (set to darkGray300)
      side: const BorderSide(color: JAppColors.primary),  // Border color (set to primary color)
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight),  // Vertical padding from JSizes
      textStyle: const TextStyle(
          fontSize: 16,  // Font size set to 16
          color: JAppColors.lightGray100, // Text color for dark mode (set to lightGray100)
          fontWeight: FontWeight.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.buttonRadius)),  // Button radius from JSizes
    ),
  );
}
