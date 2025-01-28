import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class JOutlinedButtonTheme{


  JOutlinedButtonTheme._();

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: JAppColors.dark,
      side: const BorderSide(color: JAppColors.darkGray100),
      textStyle: const TextStyle(fontSize: 16, color: JAppColors.darkGray900, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: JAppColors.light,
      side: const BorderSide(color: JAppColors.lightGray200),
      textStyle: const TextStyle(fontSize: 16, color: JAppColors.lightGray100, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: JSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(JSizes.buttonRadius)),
    ),
  );
}