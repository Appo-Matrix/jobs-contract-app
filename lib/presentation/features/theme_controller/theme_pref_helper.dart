import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefHelper {
  static const String _keyThemeMode = 'theme_mode';

  static Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyThemeMode, isDarkMode);
  }

  static Future<bool?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyThemeMode); // returns null if not saved yet
  }
}
