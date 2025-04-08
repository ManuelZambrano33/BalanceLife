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
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Buenos días, Andrea"), //VA EL NOMBRE DEL USUARIO LOGUEADO
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'), 
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          
          children: [
            SizedBox(height: 20),
            Text(
              "¿Qué hábito quieres trabajar hoy?", 
            style: TextStyle(fontSize: 18)
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,  
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 80,
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

      // TODO: AQUÍ EL NAVIGATOR SE DEBE MOVER A UN COMPONENTE GENERAL, para ser utilizado en todas pa
      bottomNavigationBar: BottomNavigationBar(
        items: [
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

          if (index == 1) { // Navegar a Estadísticas
              Navigator.push(git 

                context,
                MaterialPageRoute(builder: (context) => const MenuEstadisticas()),
              );
            }
          }
      ),
    );
  }
}
