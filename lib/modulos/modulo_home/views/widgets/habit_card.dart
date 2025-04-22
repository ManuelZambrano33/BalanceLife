import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/habit_model.dart';


// Importa esta librería para generar números aleatorios

class HabitCard extends StatelessWidget {
  final HabitModel habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    // Generar una altura aleatoria entre 150 y 250 (puedes ajustar estos valores)

    return GestureDetector(
      onTap: () {
        if (habit.route.isNotEmpty) {
          Navigator.pushNamed(context, habit.route);
        }
      },
      child: SizedBox(
        height: habit.height,
        width: 200, // Asignar la altura aleatoria generada
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: habit.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color.fromARGB(255, 140, 140, 140), width: 0.5),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(habit.iconPath, height: 90, width: 90),
              Text(
                habit.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
