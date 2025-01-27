import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeGradient {
  static const LinearGradient headerGradient = LinearGradient(
    colors: [AppColors.orangeLight, AppColors.orangeDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient btnGradient = LinearGradient(
    colors: [
      AppColors.orangeDark,
      AppColors.orangeLight,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}