import 'package:flutter/material.dart';

class Info1 extends StatelessWidget {
  final String title = 'Por qué Ejercitarme'; 
  final String content = '''
Hacer ejercicio de forma regular tiene múltiples beneficios tanto físicos como mentales. Mejora la salud cardiovascular, fortalece los músculos y huesos, y ayuda a mantener un peso saludable. Además, reduce el estrés, la ansiedad y mejora el estado de ánimo gracias a la liberación de endorfinas.

La actividad física también mejora la calidad del sueño, incrementa los niveles de energía y puede prevenir enfermedades crónicas como la diabetes tipo 2, hipertensión y ciertos tipos de cáncer. 

Establecer una rutina de ejercicio, aunque sea leve o moderada, puede marcar una gran diferencia en la calidad de vida a largo plazo.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [

            Container(
              height: 185,
              decoration: const BoxDecoration(
                color: Color(0xFF094411),
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
                  Positioned(
                    top: 120,
                    left: 30,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60), 

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 18, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
                'assets/8.png', 
                fit: BoxFit.cover,
                height: 207, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
