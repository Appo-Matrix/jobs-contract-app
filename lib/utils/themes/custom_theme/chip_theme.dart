import 'package:flutter/material.dart';
import '../../constants/colors.dart'; // Your JAppColors class

class JChipTheme {
  JChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: JAppColors.lightGray400.withOpacity(0.4), // Disabled color for light mode
    labelStyle: const TextStyle(color: JAppColors.lightGray700), // Label style for light mode
    selectedColor: JAppColors.primary, // Selected color
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12), // Padding for chips
    checkmarkColor: JAppColors.lightGray100, // Checkmark color for light mode
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: JAppColors.darkGray400, // Disabled color for dark mode
    labelStyle: TextStyle(color: JAppColors.lightGray100), // Label style for dark mode
    selectedColor: JAppColors.primary, // Selected color
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12), // Padding for chips
    checkmarkColor: JAppColors.lightGray100, // Checkmark color for dark mode
  );
}
