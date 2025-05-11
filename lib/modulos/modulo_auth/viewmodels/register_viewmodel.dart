import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../model/usuario_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String nombre = '';
  String email = '';
  String password = '';

  Future<bool> register(BuildContext context) async {
    final usuario = Usuario(nombre: nombre, email: email, contrasena: password);
    // return await _authService.register(usuario);
    return false;
  }
}
