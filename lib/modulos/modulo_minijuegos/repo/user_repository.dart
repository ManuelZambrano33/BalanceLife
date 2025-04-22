import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = 'http://localhost:3000'; // Cambia al host de tu backend

  // Método para sumar puntos al usuario
  Future<void> sumarPuntos(int idUsuario, int puntosGanados) async {
    final url = Uri.parse('$baseUrl/api/usuarios/$idUsuario/puntos');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'puntosGanados': puntosGanados}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al sumar puntos');
    }
  }
}
