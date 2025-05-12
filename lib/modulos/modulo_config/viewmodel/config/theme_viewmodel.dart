import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/theme_repository.dart';
class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;
  final ThemeRepository _themeRepository;

  ThemeViewModel(this._themeRepository) {
    _loadTheme(); // Cargar el tema al crear la instancia
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _loadTheme() async {
    _isDarkMode = await _themeRepository.getThemeMode();
    notifyListeners(); // Notificar después de cargar
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _themeRepository.saveThemeMode(_isDarkMode);
    notifyListeners(); // Forzar la reconstrucción de la UI
  }

}
