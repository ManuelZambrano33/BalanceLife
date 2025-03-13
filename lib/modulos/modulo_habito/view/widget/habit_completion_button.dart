import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/habit_model.dart';
import '../../view_model/habit_view_model.dart';

class HabitCompletionButton extends StatelessWidget {
  final HabitModel habit;

  HabitCompletionButton({required this.habit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HabitViewModel>().toggleHabit(habit.id);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: habit.done ? Colors.greenAccent : Colors.grey[300],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Icon(
          Icons.check,
          size: 16,
          color: habit.done ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}
