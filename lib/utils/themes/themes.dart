import 'package:flutter/material.dart';

import '../constants/colors.dart';


class JAppTheme {
  JAppTheme._();

  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark ,
    primaryColor: AppColors.primary,
    // textTheme: PTextTheme.textTheme,
    // chipTheme: PChipTheme.chipTheme,
    // scaffoldBackgroundColor: PColors.black,
    // appBarTheme: PAppBarTheme.appBarTheme,
    // checkboxTheme: PCheckBoxTheme.checkboxTheme,
    // switchTheme: PSwitchTheme.switchTheme,
    // bottomSheetTheme: PBottomSheetTheme.bottomSheetTheme,
    // elevatedButtonTheme: PElevatedButtonTheme.elevatedButtonTheme,
    // outlinedButtonTheme: POutlinedButtonTheme.outlinedButtonTheme,
    // inputDecorationTheme: PTextFieldTheme.inputDecorationTheme,
  );

}