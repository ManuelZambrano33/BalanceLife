import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/menu_estadisticas.dart';
import 'package:front_balancelife/modulos/modulo_home/views/home_view.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0; // Indica el ítem seleccionado

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF5F5F5),
      currentIndex: _currentIndex, // Establecer el ítem seleccionado
      selectedItemColor: const Color(0xFF333333), // Color de íconos seleccionados
      unselectedItemColor: const Color.fromARGB(85, 86, 72, 72), // Color de íconos no seleccionados
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadísticas"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: "Perfil"),         
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Actualiza el índice seleccionado
        });

        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  HomeView()), // Reemplazar la pantalla actual por Inicio
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MenuEstadisticas()), // Navegar a Estadísticas
          );
        } else if (index == 2) {
          // Aquí puedes agregar la lógica para ir a "Ajustes"
          print('Navegar a Ajustes');
        }
      },
    );
  }
}
