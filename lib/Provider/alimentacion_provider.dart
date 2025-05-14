import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/general_endpoint.dart';
import 'package:front_balancelife/modulos/modulo_alimentacion/model/food_entry_model.dart';
import 'package:http/http.dart' as http;

class AlimentacionProvider extends ChangeNotifier {
  
  final String _baseUrl = GeneralEndpoint.getEndpoint('ModuloHabitoAlimentacion');


  // Estado para registrar
  bool isRegistering = false;
  bool registerSuccess = false;
  String? registerError;

  // Estado para consultar mensual
  bool isFetching = false;
  String? fetchError;
  List<FoodEntry> monthlyData = [];

  /// POST /registrar
  Future<void> registrarAlimentacion({
    required int usuarioId,
    required String tipoComida,
    required double calorias,
    required DateTime fecha,
  }) async {
    isRegistering = true;
    registerSuccess = false;
    registerError = null;
    notifyListeners();

    final url = Uri.parse('$_baseUrl/registrar');
    final body = {
      'usuario_id': usuarioId,
      'tipo_comida': tipoComida,
      'calorias': calorias,
      'fecha': fecha.toIso8601String(),
    };

    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (resp.statusCode == 201) {
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

  /// POST /obtenerCaloriasPorMes
  Future<void> obtenerCaloriasPorMes({
    required int usuarioId,
    required int mes,
    required int anio,
  }) async {
    isFetching = true;
    fetchError = null;
    monthlyData = [];
    notifyListeners();

    final url = Uri.parse('$_baseUrl/estadisticas');
    final body = {
      'usuario_id': usuarioId.toString(),
      'mes': mes.toString(),
      'anio': anio.toString(),
    };

    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body)['data'] as List;
        monthlyData = data
            .map((e) => FoodEntry.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        fetchError = 'Error ${resp.statusCode}: ${resp.body}';
      }
    } catch (e) {
      fetchError = e.toString();
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }
}