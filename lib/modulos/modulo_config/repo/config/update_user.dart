import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> updateUser(int userId, String email, String password) async {
  final response = await http.put(
    Uri.parse('https://tuapi.com/usuario/$userId'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'password': password, // Encriptada si es necesario
    }),
  );

  return response.statusCode == 200;
}
