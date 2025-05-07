import 'dart:convert';
import 'package:http/http.dart' as http;
class ChangeMailRepository {
 final String baseUrl = 'http://10.153.76.115:1802/api/ModuloUsuario';

  Future<bool> changeMail(int userId, String newEmail) async {
    final url = Uri.parse('$baseUrl/usuarios/$userId/cambiar_correo');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nuevo_correo': newEmail}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error al cambiar correo: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Excepción en cambio de correo: $e');
      return false;
    }
  }
}

