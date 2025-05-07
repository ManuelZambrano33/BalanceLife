import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/actividad_fisica_model.dart';

class ActividadFisicaRepository {
  final String baseUrl = 'http://TU_BACKEND_URL/api/actividad-fisica';

  Future<void> guardarRegistro(RegistroActividadFisica registro) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(registro.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar la actividad física');
    }
  }

  // Puedes agregar funciones para consultar historial, etc.
}
