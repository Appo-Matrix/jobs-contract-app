import 'package:flutter/material.dart';

class AppTextStyle {
  // ── dmSans TextStyle ─────────────────────────────
  static TextStyle dmSans({
    required Color color,
    required num fontSize, // accepts int or double
    required FontWeight weight,
    double height = 1.0,
    bool shouldUnderline = false,
  }) {
    return TextStyle(
      height: height,
      color: color,
      fontWeight: weight,
      fontSize: fontSize.toDouble(), // convert to double internally
      fontFamily: AppFontFamilies.dm_sans,
      decoration: shouldUnderline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );
  }

  // ── domaineArrow TextStyle ──────────────────────
  static TextStyle domaineArrow({
    required Color color,
    required num fontSize,
    required FontWeight weight,
    double height = 1.0,
    bool shouldUnderline = false,
  }) {
    return TextStyle(
      height: height,
      color: color,
      fontWeight: weight,
      fontSize: fontSize.toDouble(),
      fontFamily: AppFontFamilies.domaine_arrow,
      decoration: shouldUnderline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );
  }

  // ── onest TextStyle ─────────────────────────────
  static TextStyle onest({
    required Color color,
    required num fontSize,
    required FontWeight weight,
    double height = 1.0,
    bool shouldUnderline = false,
  }) {
    return TextStyle(
      height: height,
      color: color,
      fontWeight: weight,
      fontSize: fontSize.toDouble(),
      fontFamily: AppFontFamilies.onest,
      decoration: shouldUnderline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );
  }
}

class AppFontFamilies {
  static const String dm_sans = 'dm_sans';
  static const String domaine_arrow = 'domaine_arrow';
  static const String onest = 'onest';
}