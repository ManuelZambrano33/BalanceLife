import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/update_user.dart' as front_balancelife;
class ChangePasswordViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool success = false;
  String? error;

  Future<void> updateUserData(int userId, String email, String newPassword) async {
    isLoading = true;
    error = null;
    success = false;
    notifyListeners();

    try {
      // Aquí usarías tu repositorio para enviar la solicitud a la API
      final result = await front_balancelife.updateUser(userId, email, newPassword);
      
      if (result) {
        success = true;
      } else {
        error = 'No se pudo actualizar la información';
      }
    } catch (e) {
      error = 'Error: ${e.toString()}';
    }

    isLoading = false;
    notifyListeners();
  }
}
