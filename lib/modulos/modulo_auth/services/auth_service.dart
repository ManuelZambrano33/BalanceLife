import 'package:http/http.dart' as http;
import '../model/usuario_model.dart';

class AuthService {
  final String _baseUrl = "http://TU_BACKEND_URL"; // aqui debe poner la URL del backend

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"), //No sé si tenga como /login el endpoint, pero se puede guiar y modificar como lo tenga
      body: {'email': email, 'contraseña': password},
    );
    return response.statusCode == 200;
  }

  Future<bool> register(Usuario usuario) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/register"),
      body: usuario.toJson(),
    );
    return response.statusCode == 201;
  }
}
