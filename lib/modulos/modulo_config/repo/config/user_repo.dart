import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepo {
  final String _baseUrl = 'https://tu-api.com'; 

  Future<bool> changePassword(int userId, String newPassword) async {
    final url = Uri.parse('$_baseUrl/cambiar_contrasena');

    final response = await http.post(
      url,
      body: jsonEncode({
        'id_usuario': userId,
        'nueva_contrasena': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al cambiar la contraseña');
    }
  }
}
