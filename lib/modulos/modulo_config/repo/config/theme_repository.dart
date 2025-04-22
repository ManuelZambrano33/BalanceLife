import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static const _key = 'theme_mode';   

 
  Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, isDarkMode);
  }

 
  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;   
  }
}
