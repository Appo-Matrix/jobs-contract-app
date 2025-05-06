

import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefHelper {
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyUseSystemTheme = 'use_system_theme';

  static Future<void> saveThemeMode(bool? isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    if (isDarkMode == null) {
      // System theme selected
      await prefs.setBool(_keyUseSystemTheme, true);
      await prefs.remove(_keyThemeMode); // Remove the explicit theme setting
    } else {
      // Explicit theme selected
      await prefs.setBool(_keyUseSystemTheme, false);
      await prefs.setBool(_keyThemeMode, isDarkMode);
    }
  }

  static Future<bool?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final useSystemTheme = prefs.getBool(_keyUseSystemTheme) ?? false;

    if (useSystemTheme) {
      return null; // Indicates system theme
    }

    return prefs.getBool(_keyThemeMode); // returns explicit theme or null if not saved
  }
}
