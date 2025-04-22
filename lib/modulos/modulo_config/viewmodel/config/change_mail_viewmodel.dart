import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/change_mail_repository.dart';

class ChangeMailViewModel extends ChangeNotifier {
  final ChangeMailRepository _repository = ChangeMailRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _success = false;
  bool get success => _success;

  Future<void> changeMail(int userId, String newEmail) async {
    _isLoading = true;
    notifyListeners();

    _success = await _repository.changeMail(userId, newEmail);

    _isLoading = false;
    notifyListeners();
  }
}
