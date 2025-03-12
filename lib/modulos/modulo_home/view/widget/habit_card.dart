import 'package:flutter/material.dart';
import '../../model/habit_model.dart';

class HabitCard extends StatelessWidget {
  final HabitModel habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (habit.route.isNotEmpty) {
          Navigator.pushNamed(context, habit.route);
        }
        // Acción al presionar la tarjeta
      },
      child: Container(
        decoration: BoxDecoration(
          color: habit.color,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(habit.iconPath, height: 60),
            SizedBox(height: 10),
            Text(
              habit.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}