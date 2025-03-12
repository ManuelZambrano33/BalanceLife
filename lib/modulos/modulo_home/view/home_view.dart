import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_viewmodel.dart';
import 'widget/habit_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Buenos días, Andrea"), //VA EL NOMBRE DEL USUARIO
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'), 
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("¿Qué hábito quieres trabajar hoy?", style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: viewModel.habits.length,
                itemBuilder: (context, index) {
                  final habit = viewModel.habits[index];
                  return HabitCard(habit: habit);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadísticas"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
        ],
      ),
    );
  }
}