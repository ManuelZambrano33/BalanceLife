import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<HabitModel> _habits = [
    HabitModel(
      title: "Hidratación",
      iconPath: "assets/hidratacion.svg",
      color: Colors.orange.shade200,
      route: "/water_tracker",
      height: 200,
    ),
    HabitModel(
      title: "Actividad Física",
      iconPath: "assets/actividad_fisica.svg",
      color: Colors.blue.shade200,
      route: "/exercise",
      height: 200,
    ),
    HabitModel(
      title: "Alimentación Saludable",
      iconPath: "assets/alimentacion.svg",
      color: Colors.purple.shade200,
      route: "/healthy_food",
      height: 200,
    ),
    HabitModel(
      title: "Sueño",
      iconPath: "assets/sueno.svg",
      color: const Color.fromARGB(255, 29, 189, 180),
      route: "/sleep",
      height: 185,
    ),
    HabitModel(
      title: "Mini juegos",
      iconPath: "assets/mini_juegos.svg",
      color: const Color.fromRGBO(242,154,156,1),
      route: "/mini_games",
      height: 200,
    ),
    HabitModel(
      title: "Habitos",
      iconPath: "assets/habit.svg",
      color: const Color.fromRGBO(168,194,86,1),
      route: "/habits",
      height: 190,
    ),
  ];

  List<HabitModel> get habits => _habits;
}
