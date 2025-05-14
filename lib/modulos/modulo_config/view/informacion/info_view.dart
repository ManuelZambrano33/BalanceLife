import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/1.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/2.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/3.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/4.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/5.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/6.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/tuto.dart';
 

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFF720455),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Positioned(
                    top: 110,
                    left: 30,
                    child: Text(
                      'Información',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildInfoButton(
              title: 'Porqué Ejercitarme',
              subtitle: 'Infórmate sobre el impacto que tiene la actividad física en tu salud.',
              imagePath: 'assets/3.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info1(), 
                  ),
                );
              },
            ),
            _buildInfoButton(
              title: 'Tiempo Recomendado',
              subtitle: 'Conoce cuál es el tiempo recomendado diariamente para realizar ejercicio.',
              imagePath: 'assets/4.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info2(), 
                  ),
                );
              },
            ),
            _buildInfoButton(
              title: 'Importancia del agua',
              subtitle: 'Infórmate sobre la importancia de la hidratación para una mejor salud.',
              imagePath: 'assets/5.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info3(), 
                  ),
                );
              },
            ),
            _buildInfoButton(
              title: 'Hidratación',
              subtitle: 'Aprende cómo saber cuántos vasos debes tomar al día.',
              imagePath: 'assets/1.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info4(), 
                  ),
                );
              },
            ),
            _buildInfoButton(
              title: 'Ciclos circadianos',
              subtitle: 'Conoce más sobre qué son y en qué consisten los ciclos circadianos.',
              imagePath: 'assets/6.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info5(), 
                  ),
                );
              },
            ),
            _buildInfoButton(
              title: 'Evitar el Sedentarismo',
              subtitle: 'Tips para mantenerte activo durante el día.',
              imagePath: 'assets/2.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info6(), 
                  ),
                );
              },
            ),
            // _buildInfoButton(
            //   title: 'Tutorial',
            //   subtitle: 'Descube como usar nuestra app',
            //   imagePath: 'assets/14.png',
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Tuto(), 
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoButton({
    required String title,
    required String subtitle,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
