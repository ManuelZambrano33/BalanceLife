import '../model/logro.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LogroRepo {
  final String apiUrl = "http://10.153.76.115:1802/api/ModuloLogro/todos"; 

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
