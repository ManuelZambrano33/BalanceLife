import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/enum/habit_model.dart';

class HabitProvider {
  
  static const String _baseUrl = "https://run.mocky.io/v3/7f0a505d-ae0a-4520-b0b9-97ae817e01dc";

  static Future<List<HabitModel>> getAllHabits() async {

    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> elementos = data['elementos'];

      List<HabitModel> habits = elementos
          .map((jsonItem) => HabitModel.fromJson(jsonItem))
          .toList();

      return habits;
    } else {
      throw Exception("Error al cargar los datos: ${response.statusCode}");
    }
  }
}
