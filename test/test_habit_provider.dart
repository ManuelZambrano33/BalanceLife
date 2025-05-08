import 'package:front_balancelife/modulos/modulo_habito/model/habit_model.dart';


void main() async {
  try {
    List<HabitModel> habits = await HabitProvider.getAllHabits();
    print("Lista de hábitos recibidos:");
    for (var habit in habits) {
      print("ID: ${habit.id}, Nombre: ${habit.name}, Estado: ${habit.done}");
    }
  } catch (e) {
    print("Error al obtener los datos: $e");
  }
}