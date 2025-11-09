import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class JAppBarTheme {
  JAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: JAppColors.lightGray100,  // Light background color
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: JAppColors.lightGray900,  // Dark icons for light mode (better contrast)
      size: 24.0,
    ),
    actionsIconTheme: IconThemeData(
      color: JAppColors.lightGray900,  // Dark icons for actions in light mode
      size: 24.0,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.lightGray900,  // Dark title text for light mode (better contrast)
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: JAppColors.darkGray900,  // Dark background color
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: JAppColors.darkGray100,  // Light icons for dark mode (white)
      size: 24.0,
    ),
    actionsIconTheme: IconThemeData(
      color: JAppColors.darkGray100,  // Light icons for actions in dark mode (white)
      size: 24.0,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.darkGray100,  // Light title text for dark mode (white)
    ),
  );
}