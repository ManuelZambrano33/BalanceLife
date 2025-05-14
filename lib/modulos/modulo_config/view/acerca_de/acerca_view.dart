import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Positioned(
                    top: 110,
                    left: 30,
                    child: Text(
                      'Acerca de la App',
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

            const SizedBox(height: 40),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _AboutSection(
                      title: 'Nombre de la App',
                      content: 'HabitOS',
                    ),
                    _AboutSection(
                      title: 'Versión',
                      content: 'Versión 1.0',
                    ),
                    _AboutSection(
                      title: 'Descripción',
                      content:
                          'HabitOS es una aplicación integral de bienestar que te ayuda a mejorar tu salud física y mental mediante el seguimiento del sueño, la hidratación, la actividad física y más. Además, incluye minijuegos, un avatar personalizable y estadísticas detalladas para monitorear tu progreso.',
                    ),
                    _AboutSection(
                      title: 'Objetivo',
                      content:
                          'El objetivo de la empresa Balance Life es promover hábitos saludables y mantener el equilibrio entre cuerpo y mente, guiando al usuario en su camino hacia una vida más activa, saludable y consciente.',
                    ),
                    _AboutSection(
                      title: 'Desarrollador',
                      content: 'Balance Life',
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title;
  final String content;

  const _AboutSection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 19, 18, 18),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
