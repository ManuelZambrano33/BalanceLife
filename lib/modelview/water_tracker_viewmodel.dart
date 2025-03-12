import 'package:flutter/material.dart';
import '../repo/water_tracker_repository.dart';

class WaterTrackerViewModel extends ChangeNotifier {
  final WaterTrackerRepository _repository;

  WaterTrackerViewModel(this._repository);

  int get glasses => _repository.glasses;

  void addGlass() {
    _repository.addGlass();
    notifyListeners();
  }
}

