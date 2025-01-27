import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // App theme colors

  static const Color primary = Color(0xffd56823);
  static const Color secondary = Color(0xffe3892f);

  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, 0.707),
    colors: [
      Color(0xffd36221), //begin: begin,d36221
      Color(0xffe48c30), //begin: begin,e48c30
      Color(0xfff2ad3c), //begin: begin,efa439
    ],
  );

  // Text Colors

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textBlack = Colors.black;

  // Background Colors

  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFF222222);
  static const Color secondaryBackground = Color(0xff333333);

  // Background Containers

  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = Colors.white.withOpacity(0.1);


  // Error and validation colors
  static const Color error = Color(0xFFED1010);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFD33535);
  static const Color info = Color(0xFF1976D2);


  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  // Border colors
  static  Color borderPrimary = AppColors.primary;
  static const Color borderSecondary = Color(0xFFE6E6E6);

  static const Color buttonDisabled = Color(0xFFC4C4C4);



// Later to be fixed
// Arshaman Colors

  static const Color borderSide = Color(0xFFD8A537);
  static const Color orangeDark = Color(0xFFD36221);
  static const Color orangeLight = Color(0xFFF2AD3C);
  static const Color whiteFFF = Color(0xFFFFFFFF);
  static const Color background = Color(0xFF222222);
  static const Color suffixcolor = Color(0xFFD5DDE2);
  static const Color iconcolor = Color(0xFF668091);
  static const Color transparent = Colors.transparent;
  static const Color pinboarder = Color(0xFFD5DDE2);
  static const Color numberbtn = Color(0xFF141414);
  static const Color greyDADADA = Color(0xFFDADADA);
  static const Color btnLabel = Color(0xFF8E8E93);
  static const Color darkGrey7E8088 = Color(0xFF7E8088);
  static const Color sliderActive = Color(0xFF32D74B);
  static const Color stackCardColor1 = Color(0xFFFFD60A);
  static const Color stackCardColor2 = Color(0xFF5E5CE6);
  static const Color successDialog = Color(0xFF25C866);
  static const Color warningDialog = Color(0xFFD33535);

// static const Color primary = Color(0xFF222222);
// static const Color secondry = Color(0xFFFFFFFF);
}