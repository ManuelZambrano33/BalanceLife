import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_balancelife/Provider/general_endpoint.dart';

class HidratacionStat {
  final DateTime fecha;
  final int cantidad;

  HidratacionStat({required this.fecha, required this.cantidad});

  factory HidratacionStat.fromJson(Map<String, dynamic> json) {
    var stats = HidratacionStat(
      fecha: DateTime.parse(json['fecha_completa'] as String),
      cantidad: int.tryParse(json['total_agua'].toString()) ?? 0,
    );

    print("HidratacionStat: $stats");
    return stats;
  }
}

class HidratacionProvider {
  static const String module = "ModuloHabitoHidratacion";

  static Future<List<HidratacionStat>> obtenerEstadisticas({
    required int usuarioId,
    required int mes,
    required int anio,
  }) async {
    final url = GeneralEndpoint.getEndpoint('$module/estadisticas');

    final date = DateTime(anio, mes);

    print("date enviada: $date");
    final body = jsonEncode({
      'id_usuario': usuarioId.toString(),
      'date': date.toIso8601String(),
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print("Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        
        return data
            .map((e) => HidratacionStat.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        print("Error al obtener estadísticas: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error en la solicitud de estadísticas: $e");
      return [];
    }
  }

  static Future<bool> registrarHidratacion({
    required int usuarioId,
    required int cantidad,
    required DateTime fecha,
  }) async {
    final url = GeneralEndpoint.getEndpoint('$module/registrar');

    final body = jsonEncode({
      'id_usuario': usuarioId,
      'cantidad': cantidad,
      'fecha': fecha.toIso8601String(),
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print("Registro de hidratación exitoso.");
        return true;
      } else {
        print("Error en el registro: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error al registrar hidratación: $e");
      return false;
    }
  }
}