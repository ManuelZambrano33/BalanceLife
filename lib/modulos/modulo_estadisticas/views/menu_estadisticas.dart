import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/widgets/custom_button_menu_estadistica.dart';

class MenuEstadisticas extends StatelessWidget {
  const MenuEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center, // Centrado horizontal
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 84, 110, 122),
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
                    top: 50,
                    right: 10,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        'assets/hidratacion.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 120),

            // Container de texto centrado
            Container(
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 48, 153, 202).withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all (
                 color: Color.fromARGB(255, 84, 110, 122),
                  width: 2
                )
              ),
              child: const Text(
                'La constancia te permitirá alcanzar tus objetivos.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF3F414E),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          // Espacio entre el texto y los botones

            // Columna con las filas de botones
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrado verticalmente
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centra los botones dentro del Row
                  children: [
                    CustomMenuButton(
                      text: 'Sueño',
                      onPressed: () {
                        Navigator.pushNamed(context, '/progreso_diario');
                      },
                    ),
                    const SizedBox(width: 20), // Espacio entre botones
                    CustomMenuButton(
                      text: 'Hidratación',
                      onPressed: () {
                        Navigator.pushNamed(context, '/estadisticas_mensuales');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Espacio entre las filas de botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centra los botones dentro del Row
                  children: [
                    CustomMenuButton(
                      text: 'Alimentación',
                      onPressed: () {
                        Navigator.pushNamed(context, '/historial_habitos');
                      },
                    ),
                    const SizedBox(width: 20), // Espacio entre botones
                    CustomMenuButton(
                      text: 'Actividad física',
                      onPressed: () {
                        Navigator.pushNamed(context, '/comparacion_resultados');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
