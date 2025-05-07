import 'package:http/http.dart' as http;
import '../model/usuario_model.dart';

class AuthService {
  final String _baseUrl = "http://10.153.76.115:1802/api/ModuloUsuario";

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/iniciarSesion"),
      body: {
        'email': email,
        'password': password,
      },
    );

    // Si el backend devuelve 200 y algún contenido, asumimos login exitoso
    return response.statusCode == 200 && response.body.isNotEmpty;
  }

  Future<bool> register(Usuario usuario) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/registrar"),
      body: usuario.toJson(), // Asegúrate que toJson genera los campos requeridos
    );

    // El backend puede devolver 200 o 201 dependiendo cómo manejes el insert
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
