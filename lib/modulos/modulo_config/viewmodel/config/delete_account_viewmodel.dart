import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/delete_user.dart';

class DeleteAccountViewModel extends ChangeNotifier {
  final DeleteUserRepo _userRepo = DeleteUserRepo();

  bool _isLoading = false;
  bool _success = false;
  String? _error;

  bool get isLoading => _isLoading;
  bool get success => _success;
  String? get error => _error;

  Future<void> deleteAccount(int userId) async {
    _isLoading = true;
    _error = null;
    _success = false;
    notifyListeners();

    try {
      final result = await _userRepo.deleteUser(userId);
      _success = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
