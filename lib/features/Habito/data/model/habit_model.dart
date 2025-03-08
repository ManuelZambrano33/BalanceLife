
import 'habit_enums.dart';

class HabitModel {
  String id;
  String name;
  HabitCategory category;
  List<String> days;
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
      days: List<String>.from(json['days']),
      reminder: HabitReminder.values[json['reminder']],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category.index,
        'days': days,
        'reminder': reminder.index,
        'done': done,
  };

}