import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthService{
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
   
  // Métodos para acceder al almacenamiento seguro 
  Future<String?> readSessionToken() async {
    return await _storage.read(key: 'session_token');  // Token de corta duración
  }

  Future<void> writeSessionToken(String token) async {
    await _storage.write(key: 'session_token', value: token);  // Guardar token de sesión
  }

  // Eliminar el token de sesión cuando el usuario cierre la aplicación
  Future<void> deleteSessionToken() async {
    await _storage.delete(key: 'session_token');  // Eliminar el token
  }

  // 

  // Métodos para acceder al almacenamiento seguro
  Future<String?> readToken() async {
    return await _storage.read(key: 'long_lived_token');
  }

  Future<void> writeToken(String token) async {
    await _storage.write(key: 'long_lived_token', value: token);
  }

  // Método para eliminar el token de larga duración
  Future<void> deleteToken() async {
    await _storage.delete(key: 'long_lived_token');
  }

  // Método para verificar si la biometría está disponible
  Future<bool> checkBiometricCapabilities() async {
    return await _localAuth.canCheckBiometrics;
  }

}