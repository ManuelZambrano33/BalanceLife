import 'package:flutter/material.dart';

class HabitDaysSelector extends StatelessWidget {
  final List<bool> selectedDays;

  HabitDaysSelector({required this.selectedDays});

  final List<String> weekDays = ["L", "M", "M", "J", "V", "S", "D"];
  final List<Color> activeColors = [
    Color(0xFFB3E5FC), // Celeste claro
    Color(0xFFB3E5FC),
    Color(0xFFB3E5FC),
    Color(0xFFB3E5FC),
    Color(0xFFB3E5FC),
    Color(0xFFFFCDD2), // Rosa claro
    Color(0xFFFFCDD2),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(7, (index) {
        bool isSelected = selectedDays[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isSelected ? activeColors[index] : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            weekDays[index],
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        );
      }),
    );
  }
}
