import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class JTextTheme {
  JTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    // Headlines - Large display text
    headlineLarge: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: JAppColors.lightGray900,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.lightGray900,
    ),
    headlineSmall: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.lightGray800,
    ),

    // Titles - Section headers
    titleLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.lightGray900,
    ),
    titleMedium: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: JAppColors.lightGray800,
    ),
    titleSmall: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: JAppColors.lightGray700,
    ),

    // Body - Main content text
    bodyLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.lightGray800,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.lightGray700,
    ),
    bodySmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.lightGray600,
    ),

    // Labels - Small UI text, captions
    labelLarge: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: JAppColors.lightGray700,
    ),
    labelMedium: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.lightGray600,
    ),
    labelSmall: const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.lightGray500,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    // Headlines - Large display text
    headlineLarge: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: JAppColors.darkGray100,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.darkGray100,
    ),
    headlineSmall: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.darkGray200,
    ),

    // Titles - Section headers
    titleLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: JAppColors.darkGray100,
    ),
    titleMedium: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: JAppColors.darkGray200,
    ),
    titleSmall: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: JAppColors.darkGray300,
    ),

    // Body - Main content text
    bodyLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.darkGray200,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.darkGray300,
    ),
    bodySmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.darkGray400,
    ),

    // Labels - Small UI text, captions
    labelLarge: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: JAppColors.darkGray300,
    ),
    labelMedium: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.darkGray400,
    ),
    labelSmall: const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w400,
      color: JAppColors.darkGray500,
    ),
  );
}