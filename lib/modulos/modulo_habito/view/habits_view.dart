import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/habit_view_model.dart';
import 'widget/habit_card.dart';

class HabitsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final habitViewModel = Provider.of<HabitViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text('Mis hábitos', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/estadisticas.png'), // Cambia la imagen por la correcta
              radius: 16,
            ),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("¿Qué hábito quieres trabajar hoy?", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 16),
            Expanded(
              child: habitViewModel.habits.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: habitViewModel.habits.length,
                      itemBuilder: (context, index) {
                        final habit = habitViewModel.habits[index];
                        return HabitCard(habit: habit);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addHabit');
        },
        backgroundColor: Color(0xFFB6A4E9),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text('No tienes hábitos aún', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
          SizedBox(height: 8),
          Text('Agrega uno nuevo para comenzar', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
        ],
      ),
    );
  }
}
