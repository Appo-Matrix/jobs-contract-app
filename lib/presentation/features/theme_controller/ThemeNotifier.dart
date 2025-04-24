// import 'package:flutter/material.dart';
// import 'package:job_contracts/presentation/features/theme_controller/theme_pref_helper.dart';
//
// class ThemeNotifier extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;
//
//   ThemeMode get themeMode => _themeMode;
//
//   ThemeNotifier() {
//     _loadTheme(); // Load saved theme on creation
//   }
//
//   void toggleTheme(bool isDark) {
//     _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//     ThemePrefHelper.saveThemeMode(isDark);
//     notifyListeners();
//   }
//
//   void _loadTheme() async {
//     final isDark = await ThemePrefHelper.loadThemeMode();
//     if (isDark != null) {
//       _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//       notifyListeners();
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/theme_controller/theme_pref_helper.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    _loadTheme(); // Load saved theme on creation
  }

  void toggleTheme(bool? isDark) {
    if (isDark == null) {
      _themeMode = ThemeMode.system;
      ThemePrefHelper.saveThemeMode(null); // Save null to indicate system theme
    } else {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      ThemePrefHelper.saveThemeMode(isDark);
    }
    notifyListeners();
  }

  void _loadTheme() async {
    final isDark = await ThemePrefHelper.loadThemeMode();
    if (isDark == null) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }
}

// Updated ThemePrefHelper to support system theme (null value)

// Updated bottom sheet implementation
