import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_habito/model/config_colors.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar%20.dart';
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
         automaticallyImplyLeading: false, // Oculta el botón de "atrás"
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("!Recuerda tus compromisos!", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 10),
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
        backgroundColor: HabitColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: CustomBottomNavBar(),  
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
