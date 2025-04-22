import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String email = "";
  String password = "";
  bool isLoading = false;
  
  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); 
    
    isLoading = false;
    notifyListeners();

    // Navegación a Home si es válido (esto lo cambias según autenticación real)
    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correo o contraseña incorrectos")),
      );
    }
  }
}