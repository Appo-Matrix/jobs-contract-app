import 'package:flutter/material.dart';
import '../../constants/colors.dart'; // Your JAppColors class

class JBottomSheetTheme {
  JBottomSheetTheme._();

  static final BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: JAppColors.white, // White background for light mode
    modalBackgroundColor: JAppColors.white, // White modal background
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  static final BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: JAppColors.darkGray800, // Dark background color (slightly lighter than darkGray900)
    modalBackgroundColor: JAppColors.darkGray800, // Dark modal background
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}