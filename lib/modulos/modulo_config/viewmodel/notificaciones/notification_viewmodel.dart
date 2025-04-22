import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/model/notification_model.dart';
 


class NotificationViewModel extends ChangeNotifier {
  NotificationModel _notificationModel = NotificationModel(isEnabled: true);

  bool get isEnabled => _notificationModel.isEnabled;

  void toggleNotification() {
    _notificationModel.isEnabled = !_notificationModel.isEnabled;
    notifyListeners();
  }
}
