import 'enum/habit_enums.dart';
import 'dart:convert';

List<HabitModel> habitListModelFromJson(String str) =>
    List<HabitModel>.from(json.decode(str).map((x) => HabitModel.fromJson(x)));

String habitListModelToJson(List<HabitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HabitModel {
  String id;
  String name;
  HabitCategory category;
  List<bool> days; // Cambio aquí para asegurar que sea List<bool>
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

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'],
      name: json['name'],
      category: HabitCategory.values[json['category']],
      days: List<String>.from(json['days']).map((day) => day == "true").toList(), // Conversión de String a bool
      reminder: HabitReminder.values[json['reminder']],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category.index,
        'days': days.map((day) => day.toString()).toList(), // Conversión de bool a String
        'reminder': reminder.index,
        'done': done,
      };
}
