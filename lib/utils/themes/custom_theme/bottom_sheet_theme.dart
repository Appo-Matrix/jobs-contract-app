import 'package:flutter/material.dart';
import '../../constants/colors.dart'; // Your JAppColors class

class JBottomSheetTheme {
  JBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: JAppColors.lightGray100, // Light background color
    modalBackgroundColor: JAppColors.lightGray100, // Light modal background
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: JAppColors.darkGray900, // Dark background color
    modalBackgroundColor: JAppColors.darkGray900, // Dark modal background
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
