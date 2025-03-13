import 'package:flutter/material.dart';
import '../../models/habit_model.dart';

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
      },
      child: SizedBox(
        height: 350,
        width: 350,
        child: Container(
          decoration: BoxDecoration(
            color: habit.color,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              Image.asset(habit.iconPath, height: 60),
              const SizedBox(height: 10),
              Text(
                habit.title,
                style: const TextStyle(
                  fontSize: 16,
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
