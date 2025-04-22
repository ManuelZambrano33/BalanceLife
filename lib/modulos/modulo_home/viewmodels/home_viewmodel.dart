import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<HabitModel> _habits = [
    HabitModel(
      title: "Hidratación",
      iconPath: "assets/hidratacion.png",
      color: const Color(0xFF690B22),
      route: "/water_tracker",
      height: 200,
    ),
    HabitModel(
      title: "Actividad Física",
      iconPath: "assets/actividadF.svg",
      color: const Color(0xFFE07A5F),
      route: "/exercise",
      height: 200,
    ),
    HabitModel(
      title: "Alimentación Saludable",
      iconPath: "assets/alimentacion.png",
      color: const Color(0xFF1B4D3E),
      route: "/healthy_food",
      height: 200,
    ),
    HabitModel(
      title: "Sueño",
      iconPath: "assets/sueno.png",
      color: const Color(0xFFF1C27D),
      route: "/sleep_page",
      height: 200,
    ),
    HabitModel( 
      title: "Mini juegos",
      iconPath: "assets/mini_juegos.png",
      color: const Color(0xFFB34D44),
      route: "/home_juegos",
      height: 200,
    ),
    HabitModel(
      title: "Habitos",
      iconPath: "assets/habit.png",
      color: const Color(0xFF3A4D40),
      route: "/habits",
      height: 200,
    ),
  ];

  List<HabitModel> get habits => _habits;
}
