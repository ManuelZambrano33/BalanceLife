import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/food_entry_model.dart'; // Usa el modelo correcto

class FoodEntryRepo {
  final String _baseUrl = 'http://10.153.76.115:1802/api/ModuloHabitoAlimentacion';

  Future<bool> saveEntry(FoodEntry entry) async {
    final url = Uri.parse('$_baseUrl/registrarAlimentacion');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tipo_comida': entry.tipoComida,
        'cantidad': entry.cantidad,
        'calorias': entry.calorias,
        'fecha': entry.fecha.toIso8601String(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Error al guardar la entrada de comida: ${response.statusCode}');
    }
  }
}
