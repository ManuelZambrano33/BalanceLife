import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/general_endpoint.dart';
import 'package:http/http.dart' as http;

class SleepStat {
  final DateTime fecha;
  final double duracion;

  SleepStat({required this.fecha, required this.duracion});

  factory SleepStat.fromJson(Map<String, dynamic> json) {
    return SleepStat(
      fecha: DateTime.parse(json['fecha']),
      duracion: (json['duracion_horas'] as num).toDouble(),
    );
  }
}

class SleepProvider extends ChangeNotifier {

  final _baseUrl = GeneralEndpoint.getEndpoint('ModuloHabitoSueno');

  // Estado registro
  bool isRegistering = false;
  bool registerSuccess = false;
  String? registerError;

  // Estado estadísticas
  bool isFetching = false;
  String? fetchError;
  List<SleepStat> stats = [];

  /// Registrar sueño 
  Future<void> registrarSueno({
    required int usuarioId,
    required double duracionHoras,
    required DateTime fecha,
  }) async {
    isRegistering = true;
    registerSuccess = false;
    registerError = null;
    notifyListeners();

    final url = Uri.parse('$_baseUrl/registrar');
    final body = {
      'usuario_id': usuarioId,
      'duracion_horas': duracionHoras,
      'fecha': fecha.toIso8601String(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
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

  /// Obtener estadísticas mensuales 
  Future<void> obtenerEstadisticas({
    required int usuarioId,
    required int mes,
    required int anio,
  }) async {
    isFetching = true;
    fetchError = null;
    stats = [];
    notifyListeners();

    final url = Uri.parse('$_baseUrl/estadisticas');
    final body = {
      'usuario_id': usuarioId.toString(),
      'mes': mes.toString(),
      'anio': anio.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        stats = data.map((e) => SleepStat.fromJson(e)).toList();
      } else {
        fetchError = 'Error ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      fetchError = e.toString();
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }
}
