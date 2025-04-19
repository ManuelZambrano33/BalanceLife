import 'package:flutter/material.dart';

class LanguageViewModel with ChangeNotifier {
  Locale _locale = const Locale('es');

  Locale get locale => _locale;

  void changeLanguage(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();   
  }
}
