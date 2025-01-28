import 'package:flutter/material.dart';
import '../../constants/colors.dart'; // Your JAppColors class
import '../../constants/sizes.dart';

class JCheckBoxTheme {
  JCheckBoxTheme._();

  /// Customizable Light Checkbox Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.xs)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return JAppColors.lightGray100; // Check color for selected state
      } else {
        return JAppColors.lightGray700; // Check color for unselected state
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return JAppColors.primary; // Fill color for selected state
      } else {
        return Colors.transparent; // Transparent for unselected state
      }
    }),
  );

  /// Customizable Dark Checkbox Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.xs)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return JAppColors.lightGray100; // Check color for selected state
      } else {
        return JAppColors.darkGray300; // Check color for unselected state
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return JAppColors.primary; // Fill color for selected state
      } else {
        return Colors.transparent; // Transparent for unselected state
      }
    }),
  );
}
