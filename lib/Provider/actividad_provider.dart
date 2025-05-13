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
    print("👉 JSON recibido: $json");
    print("👉 Tipo de pasos: ${json['pasos'].runtimeType}");
    print("👉 Tipo de kilometros: ${json['kilometros'].runtimeType}");
    
    // Manejo seguro de la fecha
    final fechaUtc = DateTime.parse(json['fecha_completa']);
    final fecha = DateTime(fechaUtc.year, fechaUtc.month, fechaUtc.day);
    
    // Conversión segura de pasos
    final pasos = json['pasos'] is String 
        ? int.tryParse(json['pasos']) ?? 0
        : (json['pasos'] as num?)?.toInt() ?? 0;
    
    // Conversión segura de kilómetros
    final kilometros = json['kilometros'] is String
        ? double.tryParse(json['kilometros']) ?? 0.0
        : (json['kilometros'] as num?)?.toDouble() ?? 0.0;

    return ActividadFisicaStat(
      fecha: fecha,
      pasos: pasos,
      kilometros: kilometros,
    );
  }
}

class ActividadFisicaProvider extends ChangeNotifier {
  final String _baseUrl = 'http://192.168.1.7:3000/api/ModuloHabitoActividadFisica';

  bool isRegistering = false;
  bool registerSuccess = false;
  String? registerError;

  bool isFetchingStats = false;
  String? statsError;
  List<ActividadFisicaStat> statsData = [];

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
      _pasosIniciales = -1;
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

  Future<void> guardarActividad(int idHabito) async {
    await registrarActividad(
      usuarioId: idHabito,
      pasos: _pasos,
      kilometros: _distancia,
      fecha: DateTime.now(),
    );
  }

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

  /// Obtiene las estadísticas de actividad física del usuario 
  Future<void> obtenerEstadisticas({
    required int usuarioId,
    required int mes,
    required int anio,
  }) async {
    isFetchingStats = true;
    statsError = null;
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
        final decoded = jsonDecode(response.body);
        if (decoded['data'] is List) {
          final data = decoded['data'] as List;
          print("✅ Datos recibidos: ${data.length} registros");
          
          // Procesar y ordenar los datos por fecha
          statsData = data.map((item) => ActividadFisicaStat.fromJson(item)).toList()
            ..sort((a, b) => a.fecha.compareTo(b.fecha));
          
          print("📊 Datos procesados: ${statsData.length} días");
        } else {
          statsError = 'Formato de datos incorrecto';
          statsData = [];
        }
      } else {
        statsError = 'Error ${response.statusCode}: ${response.body}';
        statsData = [];
      }
    } catch (e) {
      statsError = 'Error al obtener estadísticas: $e';
      statsData = [];
      print("❌ Error: $e");
    } finally {
      isFetchingStats = false;
      notifyListeners();
    }
  }
}
