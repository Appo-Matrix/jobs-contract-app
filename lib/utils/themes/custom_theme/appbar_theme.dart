import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class JAppBarTheme {
  JAppBarTheme._();

  static var lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: JAppColors.lightGray100,  // Light background color
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: JAppColors.darkGray900,  // Icon color for light mode
      size: 24.0,  // Adjust to your desired size
    ),
    actionsIconTheme: IconThemeData(
      color: JAppColors.darkGray900,  // Icon color for actions in light mode
      size: 24.0,  // Adjust to your desired size
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.darkGray800,  // Title text color for light mode
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: JAppColors.darkGray900,  // Dark background color
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: JAppColors.lightGray100,  // Icon color for dark mode
      size: 24.0,  // Adjust to your desired size
    ),
    actionsIconTheme: IconThemeData(
      color: JAppColors.lightGray100,  // Icon color for actions in dark mode
      size: 24.0,  // Adjust to your desired size
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.lightGray100,  // Title text color for dark mode
    ),
  );
}
