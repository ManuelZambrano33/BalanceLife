import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/habit_view_model.dart';
import 'package:front_balancelife/modulos/modulo_habito/view/widget/habit_card.dart';

class HabitsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final habitViewModel = Provider.of<HabitViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9), // Fondo claro como en la imagen 2
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Mis hábitos',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí va la lógica para agregar un hábito nuevo
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
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
          Text(
            'No tienes hábitos aún',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Agrega uno nuevo para comenzar',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
