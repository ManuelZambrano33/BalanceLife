import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

 
  static const Map<String, Map<String, String>> _values = {
    'en': {
      'title': 'Account Settings',
      'change_language': 'Change Language',
      'change_password': 'Change Password',
      'change_email': 'Change Email',
      'delete_account': 'Delete Account',
      'logout': 'Log out',
    },
    'es': {
      'title': 'Configuración de Cuenta',
      'change_language': 'Cambiar Idioma',
      'change_password': 'Cambiar Contraseña',
      'change_email': 'Cambiar Correo',
      'delete_account': 'Eliminar Cuenta',
      'logout': 'Cerrar sesión',
    },
  };

 
  String translate(String key) {
    return _values[locale.languageCode]?[key] ?? key;
  }

 
  static const List<LocalizationsDelegate<dynamic>> delegates = [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

 
  static const List<Locale> supportedLocales = [
    Locale('es'),
    Locale('en'),
  ];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['es', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}