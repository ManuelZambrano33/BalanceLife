import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/theme_repository.dart';
 
class ThemeViewModel extends ChangeNotifier {
  final ThemeRepository _themeRepository;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeViewModel(this._themeRepository);

 
  Future<void> initialize() async {
    _isDarkMode = await _themeRepository.getThemeMode();
    notifyListeners();   
  }

 
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _themeRepository.saveThemeMode(_isDarkMode);
    notifyListeners();   
  }

 
  ThemeMode get currentThemeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
