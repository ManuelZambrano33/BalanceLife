import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import '../models/actividad_fisica_model.dart';
import '../repo/actividad_fisica_repository.dart';

class ActividadFisicaViewModel extends ChangeNotifier {
  final ActividadFisicaRepository repository;

  int pasos = 0;
  double distancia = 0.0;

  late StreamSubscription<StepCount> _subscription;
  bool _isCounting = false;
  int _pasosIniciales = -1;
  Timer? _midnightTimer;

  static const double _stepLengthMeters = 0.8; // Longitud promedio de paso en metros

  ActividadFisicaViewModel(this.repository) {
    iniciarContador();
    _scheduleMidnightReset();
  }

  /// Inicia la suscripción al podómetro una sola vez
  void iniciarContador() {
    if (_isCounting) return;
    _isCounting = true;
    try {
      _subscription = Pedometer.stepCountStream.listen(
        _onStepCount,
        onError: _onStepCountError,
      );
    } catch (e) {
      debugPrint("Error al iniciar el podómetro: $e");
    }
  }

  /// Programa reinicio al siguiente medianoche local
  void _scheduleMidnightReset() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final duration = nextMidnight.difference(now);
    _midnightTimer = Timer(duration, () {
      _pasosIniciales = -1;
      // Notificar cambio inmediato si es necesario
      pasos = 0;
      distancia = 0.0;
      notifyListeners();
      // Volver a programar para la próxima medianoche
      _scheduleMidnightReset();
    });
  }

  /// Maneja cada evento de conteo de pasos
  void _onStepCount(StepCount event) {

    // Fija la línea base solo en el primer evento tras reinicio
    if (_pasosIniciales < 0) {
      _pasosIniciales = event.steps;
      debugPrint("Línea base establecida en $_pasosIniciales");
    }

    pasos = event.steps - _pasosIniciales;
    distancia = pasos * _stepLengthMeters / 1000; // Convertir metros a km
    notifyListeners();
    debugPrint("pasos: $pasos, distancia: ${distancia.toStringAsFixed(3)} km");
  }

  void _onStepCountError(error) {
    debugPrint('Error en podómetro: $error');
  }

  /// Guarda la actividad en el backend, incluye marca de fecha
  Future<void> guardarActividad(int idHabito) async {
    final registro = RegistroActividadFisica(
      idHabito: idHabito,
      distancia: distancia,
      pasos: pasos,
      fecha: DateTime.now(),
    );
    debugPrint(" Guardando registro: ${registro.toJson()}");
    try {
      await repository.guardarRegistro(registro);
      debugPrint("Actividad registrada correctamente");
    } catch (e) {
      debugPrint("Error al guardar actividad: $e");
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _midnightTimer?.cancel();
    super.dispose();
  }
}
