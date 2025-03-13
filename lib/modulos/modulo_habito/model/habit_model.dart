import 'enum/habit_enums.dart';
import 'dart:convert';

//  Funciones de conversión de listas JSON a modelos y viceversa
List<HabitModel> habitListModelFromJson(String str) =>
    List<HabitModel>.from(json.decode(str).map((x) => HabitModel.fromJson(x)));

String habitListModelToJson(List<HabitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//Modelo principal HabitModel
class HabitModel {
  String id;
  String name;
  HabitCategory category;
  List<bool> days;
  HabitReminder reminder;
  bool done;

  HabitModel({
    required this.id,
    required this.name,
    required this.category,
    required this.days,
    required this.reminder,
    required this.done,
  });

  //  Factory para crear un HabitModel desde un JSON
  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: HabitCategory.values[json['category'] as int],

      // Convierte la lista de valores dinámicos a bool
      days: List<bool>.from(json['days'].map((day) => day is bool ? day : day == 'true')),

      reminder: HabitReminder.values[json['reminder'] as int],

      done: json['done'] is bool ? json['done'] : json['done'] == 'true',
    );
  }

  //  Convierte el modelo en un JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category.index,

        //  Manda la lista de bools tal cual o conviértela si es necesario
        'days': days,

        'reminder': reminder.index,
        'done': done,
      };
}
