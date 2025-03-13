import 'package:flutter/material.dart';
import '../model/habit_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<HabitModel> _habits = [
    HabitModel(title: "Hidratación", iconPath: "assets/hidratacion.png", color: Colors.orange.shade200, route: "/water_tracker"),
    HabitModel(title: "Actividad Física", iconPath: "assets/actividad_fisica.png", color: Colors.blue.shade200, route: "/physical_activity"),
    HabitModel(title: "Alimentación Saludable", iconPath: "assets/alimentacion.png", color: Colors.purple.shade200, route: "/healthy_eating"),
    HabitModel(title: "Sueño", iconPath: "assets/sueno.png", color: Colors.grey.shade700, route: "/sleep"),
    HabitModel(title: "Mini Juegos", iconPath: "assets/mini_juegos.png", color: Colors.yellow.shade300, route: "/mini_games"),
    HabitModel(title: "Habitos", iconPath: "assets/estadisticas.png", color: Colors.blueGrey.shade600, route: "/habits"),
  ];

  List<HabitModel> get habits => _habits;
}