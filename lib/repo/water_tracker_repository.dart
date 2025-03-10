import '../model/water_tracker_data.dart';

class WaterTrackerRepository {
  final WaterTrackerData _data = WaterTrackerData();

  int get glasses => _data.glasses;

  void addGlass() {
    _data.increment();
  }
}
