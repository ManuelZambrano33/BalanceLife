import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/model/settings_model.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/settings_repository.dart';
 

class HomeConfigViewModel extends ChangeNotifier {
  final SettingsRepository _settingsRepository;
  SettingsModel? _userSettings;
  bool _isLoading = false;
  String _errorMessage = '';

  HomeConfigViewModel(this._settingsRepository);

  SettingsModel? get userSettings => _userSettings;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

 
  Future<void> loadUserSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userSettings = await _settingsRepository.fetchUserSettings();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
