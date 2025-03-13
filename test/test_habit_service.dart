import 'dart:convert';
import 'package:front_balancelife/modulos/modulo_habito/repository/habit_service.dart';
import 'package:http/http.dart' as http;
import 'package:front_balancelife/modulos/modulo_habito/model/habit_model.dart';
import 'package:front_balancelife/modulos/modulo_habito/view_model/habit_view_model.dart';
import 'package:front_balancelife/modulos/modulo_habito/repository/habit_service.dart';
void main() async {
  try {
    List<HabitModel> habits = await HabitService.getHabits();
    print("Lista de hábitos recibidos:");
    for (var habit in habits) {
      print("ID: ${habit.id}, Nombre: ${habit.name}, Estado: ${habit.done}");
    }
  } catch (e) {
    print("Error al obtener los datos: $e");
  }
}
