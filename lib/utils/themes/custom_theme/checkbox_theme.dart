import 'package:flutter/material.dart';
import '../../constants/colors.dart'; // Your JAppColors class
import '../../constants/sizes.dart';

class JCheckBoxTheme {
  JCheckBoxTheme._();

  /// Customizable Light Checkbox Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return JAppColors.white; // White check mark for selected state
      } else {
        return JAppColors.lightGray700; // Check color for unselected state
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return JAppColors.primary; // Primary purple for selected state
      } else {
        return Colors.transparent; // Transparent for unselected state
      }
    }),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: JAppColors.primary, width: 2); // Border for selected
      } else {
        return BorderSide(color: JAppColors.lightGray400, width: 2); // Gray border for unselected
      }
    }),
  );

  /// Customizable Dark Checkbox Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return JAppColors.darkGray900; // Dark check mark for contrast on selected state
      } else {
        return JAppColors.darkGray300; // Check color for unselected state
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return JAppColors.primary; // Primary purple for selected state
      } else {
        return Colors.transparent; // Transparent for unselected state
      }
    }),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: JAppColors.primary, width: 2); // Border for selected
      } else {
        return BorderSide(color: JAppColors.darkGray600, width: 2); // Gray border for unselected
      }
    }),
  );
}