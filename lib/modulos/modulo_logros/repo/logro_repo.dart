import '../model/logro.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LogroRepo {
  final String apiUrl = "http://localhost:3000/api/logros"; 

  Future<List<Logro>> fetchLogros() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Logro.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar logros");
    }
  }
}
