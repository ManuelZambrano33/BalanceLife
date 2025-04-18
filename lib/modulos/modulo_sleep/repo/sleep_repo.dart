class SleepRepo {
  static const int cycleDurationMinutes = 90;
  static const int sleepLatencyMinutes = 30;

  List<DateTime> calcularAlarmasDesdeAhora() {
    DateTime now = DateTime.now().add(Duration(minutes: sleepLatencyMinutes));
    return List.generate(3, (i) => now.add(Duration(minutes: (i + 4) * cycleDurationMinutes)));
  }

  List<DateTime> calcularAlarmasDesdeHoraDormir(DateTime horaDormir) {
    DateTime adjusted = horaDormir.add(Duration(minutes: sleepLatencyMinutes));
    return List.generate(3, (i) => adjusted.add(Duration(minutes: (i + 4) * cycleDurationMinutes)));
  }

  DateTime calcularSiesta() {
    return DateTime.now().add(Duration(minutes: 25));
  }
}
