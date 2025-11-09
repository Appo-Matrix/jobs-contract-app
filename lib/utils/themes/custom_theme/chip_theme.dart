import 'package:flutter/material.dart';
import '../../constants/colors.dart'; // Your JAppColors class

class JChipTheme {
  JChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: JAppColors.lightGray300.withOpacity(0.5), // Disabled color for light mode
    labelStyle: const TextStyle(color: JAppColors.lightGray900), // Dark text for light mode
    selectedColor: JAppColors.primary, // Primary purple for selected state
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12), // Padding for chips
    checkmarkColor: JAppColors.white, // White checkmark for light mode
    backgroundColor: JAppColors.lightGray200, // Light gray background for unselected chips
    side: const BorderSide(color: JAppColors.lightGray300, width: 1), // Subtle border
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
  );

  static final ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: JAppColors.darkGray700, // Disabled color for dark mode
    labelStyle: const TextStyle(color: JAppColors.darkGray100), // White text for dark mode
    selectedColor: JAppColors.primary, // Primary purple for selected state
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12), // Padding for chips
    checkmarkColor: JAppColors.darkGray900, // Dark checkmark for contrast on purple background
    backgroundColor: JAppColors.darkGray800, // Dark background for unselected chips
    side: const BorderSide(color: JAppColors.darkGray700, width: 1), // Subtle border
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
  );
}