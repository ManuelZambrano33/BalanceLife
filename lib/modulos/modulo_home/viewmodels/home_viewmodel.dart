import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<HabitModel> _habits = [
    HabitModel(
      title: "Hidratación",
      iconPath: "assets/hidratacion.png",
      color: const Color.fromARGB(255, 251, 222, 180),
      route: "/water_tracker",
      height: 200,
    ),
    HabitModel(
      title: "Actividad Física",
      iconPath: "assets/3.png",
      color: const Color.fromARGB(255, 211, 125, 101),
      route: "/exercise",
      height: 200,
    ),
    HabitModel(
      title: "Alimentación Saludable",
      iconPath: "assets/alimentacion.png",
      color: const Color(0xFF437A9D),
      route: "/healthy_food",
      height: 200,
    ),
    HabitModel(
      title: "Sueño",
      iconPath: "assets/sueno.png",
      color: const Color.fromARGB(245, 153, 198, 232),
      route: "/sleep_page",
      height: 200,
    ),
    HabitModel( 
      title: "Mini juegos",
      iconPath: "assets/mini_juegos.png",
      color: const Color.fromARGB(255, 41, 109, 89),
      route: "/home_juegos",
      height: 200,
    ),
    HabitModel(
      title: "Habitos",
      iconPath: "assets/habito.png",
      color: const Color.fromRGBO(168,194,86,1),
      route: "/habits",
      height: 200,
    ),
  ];

  List<HabitModel> get habits => _habits;
}
