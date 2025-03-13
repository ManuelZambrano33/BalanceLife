import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/habit_model.dart';

class HabitService {
  static const String apiUrl = "https://run.mocky.io/v3/f42cddc7-72f6-4eba-9553-efc46aeeb4f4";

  Future<List<HabitModel>> getAllHabits() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((habit) => HabitModel.fromJson(habit)).toList();
      } else {
        throw Exception("Error al obtener los hábitos");
      }
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }

  Future<void> toggleHabitCompletion(String habitId, bool isCompleted) async {
    try {
      final response = await http.put(
        Uri.parse("$apiUrl/$habitId"),
        body: json.encode({"done": isCompleted}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw Exception("Error al actualizar el hábito");
      }
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }

  Future<void> createHabit(HabitModel habit) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(habit.toJson()),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception("Error al crear el hábito");
      }
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }
  
}
