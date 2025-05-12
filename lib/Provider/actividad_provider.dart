import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedometer/pedometer.dart';

class ActividadFisicaStat {
  final DateTime fecha;
  final int pasos;
  final double kilometros;

  ActividadFisicaStat({
    required this.fecha,
    required this.pasos,
    required this.kilometros,
  });

  factory ActividadFisicaStat.fromJson(Map<String, dynamic> json) {
    return ActividadFisicaStat(
      fecha: DateTime.parse(json['fecha_completa']),
      pasos: json['pasos'],
      kilometros: (json['kilometros'] as num).toDouble(),
    );
  }
}

class ActividadFisicaProvider extends ChangeNotifier {
  final String _baseUrl = 'http://192.168.1.6:3000/api/ModuloHabitoActividadFisica';

  // ——— Estado para el registro ———
  bool isRegistering = false;
  bool registerSuccess = false;
  String? registerError;

  // ——— Estado para estadísticas ———
  bool isFetchingStats = false;
  String? statsError;
  List<ActividadFisicaStat> statsData = [];

  // ——— Estado para podómetro ———
  int _pasos = 0;
  double _distancia = 0.0;
  late StreamSubscription<StepCount> _subscription;
  int _pasosIniciales = -1;

  static const double _stepLengthMeters = 0.8;

  ActividadFisicaProvider() {
    iniciarContador();
    _scheduleMidnightReset();
  }

  int get pasos => _pasos;
  double get distancia => _distancia;

  void _onStepCount(StepCount event) {
    debugPrint("Pasos detectados: ${event.steps}");
    if (_pasosIniciales < 0) _pasosIniciales = event.steps;

    _pasos = event.steps - _pasosIniciales;
    _distancia = (_pasos * _stepLengthMeters / 1000).toDouble();

    notifyListeners(); 
  }

  void _onStepCountError(error) {
    debugPrint('Error en podómetro: $error');
  }

  void iniciarContador() {
     try {
    _pasosIniciales = -1; // Reinicia las bases
    _subscription = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
    );
    } catch (e) {
      debugPrint("Error al iniciar podómetro: $e");
    }
  }

  void _scheduleMidnightReset() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final duration = nextMidnight.difference(now);

    Timer(duration, () {
      _pasosIniciales = -1;
      _pasos = 0;
      _distancia = 0.0;
      notifyListeners();
      _scheduleMidnightReset();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  // ——— Métodos para el backend ———
  Future<void> guardarActividad(int idHabito) async {
    await registrarActividad(
      usuarioId: idHabito,
      pasos: _pasos,
      kilometros: _distancia,
      fecha: DateTime.now(),
    );
  }

  /// Registrar actividad física (POST /registrar)
  Future<void> registrarActividad({
    required int usuarioId,
    required int pasos,
    required double kilometros,
    required DateTime fecha,
  }) async {
    isRegistering = true;
    registerSuccess = false;
    registerError = null;
    notifyListeners();

    final url = Uri.parse('$_baseUrl/registrar');
    final body = jsonEncode({
      "usuario_id": usuarioId,
      "pasos": pasos,
      "kilometros": kilometros,
      "fecha": fecha.toIso8601String(),
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        registerSuccess = true;
      } else {
        registerError = 'Error ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      registerError = e.toString();
    } finally {
      isRegistering = false;
      notifyListeners();
    }
  }

  /// Obtener estadísticas mensuales (POST /estadisticas)
  Future<void> obtenerEstadisticas({
    required int usuarioId,
    required int mes,
    required int anio,
  }) async {
    isFetchingStats = true;
    statsError = null;
    statsData = [];
    notifyListeners();

    final url = Uri.parse('$_baseUrl/estadisticas');
    final body = jsonEncode({
      "usuario_id": usuarioId.toString(),
      "mes": mes.toString(),
      "anio": anio.toString(),
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        statsData = data
            .map((item) => ActividadFisicaStat.fromJson(item))
            .toList();
      } else {
        statsError = 'Error ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      statsError = e.toString();
    } finally {
      isFetchingStats = false;
      notifyListeners();
    }
  }
}