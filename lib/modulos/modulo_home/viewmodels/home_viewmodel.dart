import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<HabitModel> _habits = [
    HabitModel(
      title: "Hidratación",
      iconPath: "assets/hidratacion.png",
      color: Colors.orange.shade200,
      route: "/water_tracker",
    ),
    HabitModel(
      title: "Actividad Física",
      iconPath: "assets/actividad_fisica.png",
      color: Colors.blue.shade200,
      route: "/exercise",
    ),
    HabitModel(
      title: "Alimentación Saludable",
      iconPath: "assets/alimentacion.png",
      color: Colors.purple.shade200,
      route: "/healthy_food",
    ),
    HabitModel(
      title: "Sueño",
      iconPath: "assets/sueno.png",
      color: Colors.grey.shade700,
      route: "/sleep",
    ),
    HabitModel(
      title: "Habitos",
      iconPath: "assets/habit.png",
      color: Colors.yellow.shade300,
      route: "/habits",
    ),
    HabitModel(
      title: "Mini juegos",
      iconPath: "assets/mini_juegos.png",
      color: Colors.blueGrey.shade600,
      route: "/mini_games",
    ),
  ];

  List<HabitModel> get habits => _habits;
}
