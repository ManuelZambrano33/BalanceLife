
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HidratacionStat {
  final DateTime fecha;
  final int cantidad; 

  HidratacionStat({required this.fecha, required this.cantidad});

  factory HidratacionStat.fromJson(Map<String, dynamic> json) {
    return HidratacionStat(
      fecha: DateTime.parse(json['fecha'] as String),
      cantidad: (json['cantidad'] as num).toInt(),
    );
  }
}

class HidratacionProvider extends ChangeNotifier {
  final String _baseUrl = 'http://192.168.1.6:3000/api/ModuloHabitoHidratacion';

  // ——— Estado para el registro ———
  bool isRegistering = false;
  bool registerSuccess = false;
  String? registerError;

  // ——— Estado para estadísticas ———
  bool isFetchingStats = false;
  String? statsError;
  List<HidratacionStat> statsData = [];

  /// Llama a POST /registrarHidratacion
  Future<void> registrarHidratacion({
    required int usuarioId,
    required int cantidad,      // en ml o número de vasos, según tu backend
    required DateTime fecha,
  }) async {
    isRegistering = true;
    registerSuccess = false;
    registerError = null;
    notifyListeners();

    final url = Uri.parse('$_baseUrl/registrar'); // debe coincidir con tu ruta
    final body = jsonEncode({
      'id_usuario': usuarioId,
      'cantidad': cantidad,
      'fecha': fecha.toIso8601String(),
    });

    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (resp.statusCode == 200) {
        registerSuccess = true;
      } else {
        registerError = 'Error ${resp.statusCode}: ${resp.body}';
      }
    } catch (e) {
      registerError = e.toString();
    } finally {
      isRegistering = false;
      notifyListeners();
    }
  }

  /// Llama a POST /getEstadisticas
  Future<void> obtenerEstadisticas({
    required int usuarioId,
    required DateTime date, // la fecha desde la cual quieres estadísticas
  }) async {
    isFetchingStats = true;
    statsError = null;
    statsData = [];
    notifyListeners();

    final url = Uri.parse('$_baseUrl/estadisticas'); // o '/getEstadisticas'
    final body = jsonEncode({
      'id_usuario': usuarioId.toString(),
      'date': date.toIso8601String(),
    });

    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body)['data'] as List;
        statsData = data
            .map((e) => HidratacionStat.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        statsError = 'Error ${resp.statusCode}: ${resp.body}';
      }
    } catch (e) {
      statsError = e.toString();
    } finally {
      isFetchingStats = false;
      notifyListeners();
    }
  }
}