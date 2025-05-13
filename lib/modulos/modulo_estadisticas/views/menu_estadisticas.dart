import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/widgets/custom_button_menu_estadistica.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar.dart';

class MenuEstadisticas extends StatelessWidget {
  const MenuEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(31, 98, 129, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 140,
                    left: 35,
                    child: Text(
                      'Estadísticas',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 238, 250),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 10,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/estadisticas.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 100),

            // Eliminado el contenedor de la frase motivacional

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomMenuButton(
                    text: 'Sueño',
                    onPressed: () {
                      Navigator.pushNamed(context, '/estastisticas_sueno');
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomMenuButton(
                    text: 'Hidratación',
                    onPressed: () {
                      Navigator.pushNamed(context, '/estadisticas_hidratacion');
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomMenuButton(
                    text: 'Alimentación',
                    onPressed: () {
                      Navigator.pushNamed(context, '/historial_habitos');
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomMenuButton(
                    text: 'Actividad física',
                    onPressed: () {
                      Navigator.pushNamed(context, '/estadisticas_actividad');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        currentPageIndex: currentIndex,
      ),
    );
  }
}
