import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  // Método para guardar los datos del usuario
  Future<bool> saveUserData({
    required int id,
    required String nombre,
    required String email,
    required DateTime birthday,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.setInt('userId', id);
      await prefs.setString('nombre', nombre);
      await prefs.setString('email', email);
      await prefs.setString('birthday', birthday.toIso8601String());  // Guardamos la fecha en formato ISO
      return true;
    } catch (e) {
      print("Error al guardar los datos en SharedPreferences: $e");
      return false;
    }
  }

  // Método para obtener los datos del usuario
  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Recuperamos los datos y los devolvemos en un mapa
    return {
      'id': prefs.getInt('userId') ?? -1,  // Si no hay ID, se devuelve -1
      'nombre': prefs.getString('nombre') ?? '',
      'email': prefs.getString('email') ?? '',
      'birthday': DateTime.parse(prefs.getString('birthday') ?? DateTime.now().toIso8601String()),
    };
  }

  // Método para limpiar los datos del usuario
  Future<bool> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove('userId');
      await prefs.remove('nombre');
      await prefs.remove('email');
      await prefs.remove('birthday');
      return true;
    } catch (e) {
      print("Error al limpiar los datos en SharedPreferences: $e");
      return false;
    }
  }
}
