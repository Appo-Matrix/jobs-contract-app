// import 'package:flutter/material.dart';
//
// import '../constants/colors.dart';
// import 'custom_theme/appbar_theme.dart';
// import 'custom_theme/bottom_sheet_theme.dart';
// import 'custom_theme/checkbox_theme.dart';
// import 'custom_theme/chip_theme.dart';
// import 'custom_theme/eleveted_button_theme.dart';
// import 'custom_theme/outline_button_theme.dart';
// import 'custom_theme/text_field_theme.dart';
// import 'custom_theme/text_theme.dart';
//
// class JAppTheme {
//   JAppTheme._();
//
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     disabledColor: JAppColors.lightGray400,
//     brightness: Brightness.light,
//     primaryColor: JAppColors.primary,
//     textTheme: JTextTheme.lightTextTheme,
//     chipTheme: JChipTheme.lightChipTheme,
//     scaffoldBackgroundColor: JAppColors.white,
//     appBarTheme: JAppBarTheme.lightAppBarTheme,
//     checkboxTheme: JCheckBoxTheme.lightCheckboxTheme,
//     bottomSheetTheme: JBottomSheetTheme.lightBottomSheetTheme,
//     elevatedButtonTheme: JElevatedButtonTheme.lightElevatedButtonTheme,
//     outlinedButtonTheme: JOutlinedButtonTheme.lightOutlinedButtonTheme,
//     inputDecorationTheme: JTextFieldTheme.lightInputDecorationTheme,
//     colorScheme: ColorScheme.light(
//       primary: JAppColors.primary,
//       secondary: JAppColors.chartreuse600,
//       error: JAppColors.error500,
//       surface: JAppColors.white,
//       onPrimary: JAppColors.white,
//       onSecondary: JAppColors.lightGray900,
//       onError: JAppColors.white,
//       onSurface: JAppColors.lightGray900,
//     ),
//   );
//
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     disabledColor: JAppColors.darkGray600,
//     brightness: Brightness.dark,
//     primaryColor: JAppColors.primary,
//     textTheme: JTextTheme.darkTextTheme,
//     chipTheme: JChipTheme.darkChipTheme,
//     scaffoldBackgroundColor: JAppColors.darkGray900,
//     appBarTheme: JAppBarTheme.darkAppBarTheme,
//     checkboxTheme: JCheckBoxTheme.darkCheckboxTheme,
//     bottomSheetTheme: JBottomSheetTheme.darkBottomSheetTheme,
//     elevatedButtonTheme: JElevatedButtonTheme.darkElevatedButtonTheme,
//     outlinedButtonTheme: JOutlinedButtonTheme.darkOutlinedButtonTheme,
//     inputDecorationTheme: JTextFieldTheme.darkInputDecorationTheme,
//     colorScheme: ColorScheme.dark(
//       primary: JAppColors.primary,
//       secondary: JAppColors.chartreuse600,
//       error: JAppColors.error500,
//       surface: JAppColors.darkGray900,
//       onPrimary: JAppColors.white,
//       onSecondary: JAppColors.darkGray100,
//       onError: JAppColors.white,
//       onSurface: JAppColors.darkGray100,
//     ),
//   );
// }

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_theme/appbar_theme.dart';
import 'custom_theme/bottom_sheet_theme.dart';
import 'custom_theme/checkbox_theme.dart';
import 'custom_theme/chip_theme.dart';
import 'custom_theme/eleveted_button_theme.dart';
import 'custom_theme/outline_button_theme.dart';
import 'custom_theme/text_field_theme.dart';
import 'custom_theme/text_theme.dart';

class JAppTheme {
  JAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    disabledColor: JAppColors.lightGray400,
    brightness: Brightness.light,
    primaryColor: JAppColors.primary,
    textTheme: JTextTheme.lightTextTheme,
    chipTheme: JChipTheme.lightChipTheme,
    scaffoldBackgroundColor: JAppColors.white,
    appBarTheme: JAppBarTheme.lightAppBarTheme,
    checkboxTheme: JCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: JBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: JElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: JOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: JTextFieldTheme.lightInputDecorationTheme,
    colorScheme: ColorScheme.light(
      primary: JAppColors.primary,
      secondary: JAppColors.chartreuse600,
      error: JAppColors.error500,
      surface: JAppColors.white,
      background: JAppColors.white,  // Added background
      onPrimary: JAppColors.white,
      onSecondary: JAppColors.lightGray900,
      onError: JAppColors.white,
      onSurface: JAppColors.lightGray900,
      onBackground: JAppColors.lightGray900,  // Added onBackground
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    disabledColor: JAppColors.darkGray600,
    brightness: Brightness.dark,
    primaryColor: JAppColors.primary,
    textTheme: JTextTheme.darkTextTheme,
    chipTheme: JChipTheme.darkChipTheme,
    scaffoldBackgroundColor: JAppColors.darkGray900,
    appBarTheme: JAppBarTheme.darkAppBarTheme,
    checkboxTheme: JCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: JBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: JElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: JOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: JTextFieldTheme.darkInputDecorationTheme,
    colorScheme: ColorScheme.dark(
      primary: JAppColors.primary,
      secondary: JAppColors.chartreuse600,
      error: JAppColors.error500,
      surface: JAppColors.darkGray900,
      background: JAppColors.darkGray900,  // Added background - IMPORTANT
      onPrimary: JAppColors.white,
      onSecondary: JAppColors.darkGray100,
      onError: JAppColors.white,
      onSurface: JAppColors.darkGray100,
      onBackground: JAppColors.darkGray100,  // Added onBackground
    ),
  );
}