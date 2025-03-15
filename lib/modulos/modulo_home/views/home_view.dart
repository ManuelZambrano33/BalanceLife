import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/menu_estadisticas.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import 'widgets/habit_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final firstColumnHabits = viewModel.habits.sublist(0, 3); // Primeros 3 hábitos
    final secondColumnHabits = viewModel.habits.sublist(3); // Últimos 3 hábitos

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buenos días, Andrea"),
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              "¿Qué hábito quieres trabajar hoy?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Primera columna
                Expanded(
                  child: Column(
                    children: firstColumnHabits.map((habit) => 
                      HabitCard(habit: habit),
                    ).toList(),
                  ),
                ), 
                SizedBox(width: 20),
                // Espacio entre columnas
                Expanded(
                  child: Column(
                    children: secondColumnHabits.map((habit) => HabitCard(habit: habit)).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadísticas"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuEstadisticas()),
            );
          }
        },
      ),
    );
  }
}