import 'dart:convert';
import 'package:front_balancelife/Provider/general_endpoint.dart';
import 'package:front_balancelife/modulos/modulo_auth/services/auth_service.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static const String module = "ModuloUsuario";

  static Future<bool> login(String email, String contrasena) async {
    String url = GeneralEndpoint.getEndpoint('$module/iniciarSesion');

    Map<String, dynamic> body = {
      "email": email,
      "password": contrasena,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          UserServiceModel.id = data['data']['id_usuario'];
          UserServiceModel.nombre = data['data']['nombre'];
          UserServiceModel.email = data['data']['email'];

          final tokenSesion = data['token'];
          await AuthService().writeSessionToken(tokenSesion);

          print("ESTE ES EL TOKEN DE SESION GUARDADO POR LOGIN: $tokenSesion");
          return true;
        }
      } else {
        print("Error en la solicitud de login: ${response.statusCode}");
      }
    } catch (e) {
      print("Error en la solicitud de login: $e");
    }

    return false;
  }

  // También puedes dejar el método register aquí si deseas

  
  static Future<bool> register(String nombre, String email, String contrasena, String fechaNacimiento) async {
    String url = GeneralEndpoint.getEndpoint('$module/registrar');

    Map<String, dynamic> body = {
      "nombre": nombre,
      "email": email,
      "password": contrasena,
      "fecha_nacimiento": fechaNacimiento,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          UserServiceModel.id = data['id'];
          UserServiceModel.nombre = nombre;
          UserServiceModel.email = email;
          UserServiceModel.birthday = DateTime.parse(fechaNacimiento);

          // Guardar el token de sesión en el almacenamiento seguro
          final tokenSesion = data['token'];
          await AuthService().writeSessionToken(tokenSesion);
          print("ESTE ES EL TOKEN DE SESION GUARDADO POR REGISTROOOO: $tokenSesion");

          return true;
        }
      }

      print("Error en la solicitud de registro: ${response.statusCode}");
      return false;
    } catch (e) {
      print("Error en la solicitud de registro: $e");
      return false;
    }
  }
}
