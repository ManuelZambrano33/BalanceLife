import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {

 Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;  // Valor predeterminado si no está guardado
  }
  
}
