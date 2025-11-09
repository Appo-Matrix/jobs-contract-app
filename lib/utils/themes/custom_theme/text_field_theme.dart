import 'package:flutter/material.dart';

import '../../constants/colors.dart';  // Assuming you have your custom colors defined here
import '../../constants/sizes.dart';  // Assuming you have button sizes defined here

class JTextFieldTheme {
  JTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: JAppColors.lightGray600,  // Medium gray for icons in light mode
    suffixIconColor: JAppColors.lightGray600,  // Same for suffix icon color
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: JSizes.fontSizeMd,
      color: JAppColors.lightGray700,  // Medium dark text for labels
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: JSizes.fontSizeSm,
      color: JAppColors.lightGray500,  // Lighter gray for hints
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: JAppColors.primary,  // Primary purple when focused
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.lightGray400),  // Lighter border
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.lightGray400),  // Lighter border
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JAppColors.primary),  // Thicker primary border when focused
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.error500),  // Error border color
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JAppColors.error600),  // Darker error when focused
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,  // Consistent with light mode
    prefixIconColor: JAppColors.darkGray500,  // Medium gray for icons in dark mode
    suffixIconColor: JAppColors.darkGray500,  // Same for suffix icon color
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: JSizes.fontSizeMd,
      color: JAppColors.darkGray300,  // Light gray text for labels in dark mode
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: JSizes.fontSizeSm,
      color: JAppColors.darkGray500,  // Medium gray for hints
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: JAppColors.primary,  // Primary purple when focused
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.darkGray600),  // Medium border for dark mode
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.darkGray600),  // Medium border
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JAppColors.primary),  // Thicker primary border when focused
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JAppColors.error500),  // Error border color
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JAppColors.error600),  // Darker error when focused
    ),
  );
}