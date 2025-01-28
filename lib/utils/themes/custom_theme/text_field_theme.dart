import 'package:flutter/material.dart';

import '../../constants/colors.dart';  // Assuming you have your custom colors defined here
import '../../constants/sizes.dart';  // Assuming you have button sizes defined here

class JTextFieldTheme {
  JTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: JAppColors.darkGray400,  // Use your custom dark gray for icons
    suffixIconColor: JAppColors.darkGray400,  // Use the same for suffix icon color
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeMd, color: JAppColors.lightGray900),  // Text color for labels
    hintStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeSm, color: JAppColors.lightGray600),  // Hint text color
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: JAppColors.lightGray700.withOpacity(0.8)),  // Floating label color
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.lightGray500),  // Border color for light mode
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.lightGray500),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.primary),  // Focused border color
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.error500),  // Error border color
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JAppColors.error500),  // Focused error border color
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: JAppColors.darkGray400,  // Use custom dark gray for icons
    suffixIconColor: JAppColors.darkGray400,  // Same for suffix icon color
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeMd, color: JAppColors.lightGray100),  // Text color for labels in dark mode
    hintStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeSm, color: JAppColors.lightGray500),  // Hint text color
    floatingLabelStyle: const TextStyle().copyWith(color: JAppColors.lightGray200.withOpacity(0.8)),  // Floating label color
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.darkGray500),  // Border color for dark mode
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.darkGray500),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.primary),  // Focused border color in dark mode
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.error500),  // Error border color
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JAppColors.error500),  // Focused error border color
    ),
  );
}
