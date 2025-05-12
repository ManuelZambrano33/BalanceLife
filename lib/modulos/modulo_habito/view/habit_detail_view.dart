import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_habito/model/config_colors.dart';
import '../model/habit_model.dart';


class HabitDetailView extends StatelessWidget {
  final HabitModel habit;

  const HabitDetailView({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/${habit.category.name}.png', height: 200),
            SizedBox(height: 24),
            Text("Días asignados", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: List.generate(7, (index) {
                final days = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: habit.days[index] ? HabitColors.primary : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(days[index],
                      style: TextStyle(
                        color: habit.days[index] ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                );
              }),
            ),
            SizedBox(height: 24),
            Text("Recordar en", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Chip(
              label: Text(habit.reminder.name),
              backgroundColor: HabitColors.lightPrimary,
              labelStyle: TextStyle(color: Colors.white),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HabitColors.lightPrimary,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: Center(child: Text('Cerrar', style: TextStyle(fontSize: 16, color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
