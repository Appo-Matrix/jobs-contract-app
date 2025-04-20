import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/theme_controller/theme_pref_helper.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    _loadTheme(); // Load saved theme on creation
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    ThemePrefHelper.saveThemeMode(isDark);
    notifyListeners();
  }

  void _loadTheme() async {
    final isDark = await ThemePrefHelper.loadThemeMode();
    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}
