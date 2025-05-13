import 'dart:convert';
import 'package:front_balancelife/Provider/general_endpoint.dart';
import 'package:front_balancelife/services/auth_service.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';
import 'package:front_balancelife/services/sharedpreference_service.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static const String module = "ModuloUsuario";

  // Método para procesar los datos del usuario
  static Future<bool> _processUserData(Map<String, dynamic> userData) async {
    try {
      DateTime birthDate;
      try {
        birthDate = DateTime.parse(userData["birthdate"]);
      } catch (e) {
        print("Error al parsear la fecha: ${userData["birthdate"]}");
        birthDate = DateTime.now();
      }

      // Asignar los valores al UserServiceModel
      UserServiceModel.id_usuario = userData["id_usuario"] ?? -1;
      UserServiceModel.nombre = userData["nombre"] ?? "Sin nombre";
      UserServiceModel.email = userData["email"] ?? "email@desconocido.com";
      UserServiceModel.birthday = birthDate;

      // Guardamos los datos en SharedPreferences
      final saveResult = await SharedPreferencesService().saveUserData(
        id: UserServiceModel.id_usuario!,
        nombre: UserServiceModel.nombre!,
        email: UserServiceModel.email!,
        birthday: UserServiceModel.birthday!,
      );

      if (saveResult) {
        print("Datos del usuario guardados correctamente.");
        return true;
      } else {
        print("Error al guardar los datos en SharedPreferences.");
        return false;
      }
    } catch (e) {
      print("Error al procesar los datos del usuario: $e");
      return false;
    }
  }

  static Future<bool> loginUser(String email, String contrasena) async {
    String url = GeneralEndpoint.getEndpoint('$module/iniciarSesion');

    Map<String, dynamic> body = {
      "email": email,
      "password": contrasena,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          final tokenSesion = data['token'];
          await AuthService().writeSessionToken(tokenSesion);

          print("ESTE ES EL TOKEN DE SESION GUARDADO POR LOGIN: $tokenSesion");

          // Procesamos los datos del usuario
          var userData = data['data'];
          if (userData != null) {
            return await _processUserData(userData);  // Usamos el método separado
          } else {
            print("Error: Los datos del usuario son nulos.");
            return false;
          }
        } else {
          print("Error: Respuesta de login no exitosa. ${data['message']}");
        }
      } else {
        print("Error en la solicitud de login: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al hacer login: $e");
    }

    return false;
  }

  static Future<bool> register(String nombre, String email, String contrasena, String fechaNacimiento) async {
    String url = GeneralEndpoint.getEndpoint('$module/registrar');

    Map<String, dynamic> body = {
      "email": email,
      "fecha_nacimiento": fechaNacimiento,
      "nombre": nombre,
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
        Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          final tokenSesion = data['token'];
          await AuthService().writeSessionToken(tokenSesion);
          int id = data['id'] ?? -1;

          Map<String, dynamic> userData = {
            "nombre": nombre,
            "email": email,
            "birthdate": fechaNacimiento,  
            "id_usuario": id, 
          };
          bool result = await _processUserData(userData);

          print("Este es el id gurdado por el registro: $id");
          if (result) {
            print("Datos del usuario procesados correctamente.");
            return true;
          } else {
            print("Error al procesar los datos del usuario.");
            return false;
          }
          
        } else {
          print("Error: Respuesta del registro no exitosa. ${data['message']}");
          return false;
        }
      } else {
        print("Error en la solicitud de registro: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error al hacer el registro: $e");
      return false;
    }
  }

  static Future<bool> habilitarHuella(String email) async {
    String url = GeneralEndpoint.getEndpoint('$module/habilitarHuella');

    Map<String, dynamic> body = {
      "email": email,
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
          final String longToke = data['longLivedToken'] ?? '';
          await AuthService().writeToken(longToke);
          print("Token largo guardado correctamente: $longToke");
          return true;
        } else {
          print("Error: ${data['error']}");
          return false;
        }
      } else {
        print("Error en la solicitud: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error al habilitar huella: $e");
      return false;
    }
  }

  static Future<String?> verifyLongToken(String longToken) async {
    String url = GeneralEndpoint.getEndpoint('$module/verifyLongToken');
    Map<String, dynamic> body = {
      "longToken": longToken,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200 && data['tokenSesion'] != null) {
        final String tokenSesion = data['tokenSesion'];
        await AuthService().writeSessionToken(tokenSesion);

        var userData = data['data'];

        if (userData != null) {
          // Usamos el método para procesar y guardar los datos del usuario
          return await _processUserData(userData) ? tokenSesion : null;
        } else {
          print("Error: Los datos del usuario son nulos.");
          return null;
        }
      } else {
        print("Error en la solicitud: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error al verificar el token: $e");
      return null;
    }
  }
}
