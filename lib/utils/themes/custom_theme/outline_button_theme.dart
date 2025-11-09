import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class JOutlinedButtonTheme {
  JOutlinedButtonTheme._();

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.lightGray900,  // Dark text for light mode
      side: const BorderSide(color: JAppColors.lightGray400, width: 1.5),  // Gray border
      textStyle: const TextStyle(
        fontSize: 16,
        color: JAppColors.lightGray900,  // Dark text
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JSizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.darkGray100,  // White text for dark mode
      side: const BorderSide(color: JAppColors.darkGray600, width: 1.5),  // Medium gray border
      textStyle: const TextStyle(
        fontSize: 16,
        color: JAppColors.darkGray100,  // White text
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JSizes.buttonRadius),
      ),
    ),
  );
}