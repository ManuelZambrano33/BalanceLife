import 'package:flutter/material.dart';
import '../model/sleep_model.dart';
import '../repo/sleep_repo.dart';

class SleepViewModel extends ChangeNotifier {
  final SleepRepo _repo = SleepRepo();

  List<SleepCycle> alarmas = [];

  void generarAlarmasDesdeAhora() {
    final tiempos = _repo.calcularAlarmasDesdeAhora();
    alarmas = List.generate(tiempos.length, (i) => SleepCycle(
      wakeUpTime: tiempos[i],
      numberOfCycles: i + 4,
    ));
    notifyListeners();
  }

  void generarAlarmasDesdeHora(DateTime horaDormir) {
    final tiempos = _repo.calcularAlarmasDesdeHoraDormir(horaDormir);
    alarmas = List.generate(tiempos.length, (i) => SleepCycle(
      wakeUpTime: tiempos[i],
      numberOfCycles: i + 4,
    ));
    notifyListeners();
  }

  DateTime obtenerHoraSiesta() {
    return _repo.calcularSiesta();
  }
}
