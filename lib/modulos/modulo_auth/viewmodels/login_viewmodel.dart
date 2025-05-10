import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String email = '';
  String password = '';

  Future<bool> login(BuildContext context) async {
    // return await _authService.(email, password);
    return false;
  }
}
