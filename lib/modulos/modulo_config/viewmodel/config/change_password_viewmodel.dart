import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/user_repo.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepo();

  bool _isLoading = false;
  String? _error;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get success => _success;

  Future<void> changePassword(int userId, String newPassword) async {
    _isLoading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final result = await _userRepo.changePassword(userId, newPassword);
      _success = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
