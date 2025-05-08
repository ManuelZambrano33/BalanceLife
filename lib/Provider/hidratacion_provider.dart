import 'dart:convert';
import 'package:front_balancelife/Provider/general_endpoint.dart';
import 'package:http/http.dart' as http;

class HidratacionProvider {

  static Future<void> guardarHidratacion(int cantidad) async {

    String url = GeneralEndpoint.getEndpoint('/hidratacion');

    Map<String, dynamic> body = {
      'cantidad': cantidad
    };

    try {
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        },
        body: json.encode(body)
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = json.decode(response.body);
        print("Log en provider Hidratación: $data"); // No se devuelve nada, solo se confirmar que se guardo la hidratacion
      } else {
        throw Exception('Error al guardar la hidratación');
      }
    } catch (e) {
      print("Error en la solicitud de Hidratación: $e");
      rethrow;
    }
  }
}