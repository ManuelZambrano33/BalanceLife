import 'package:flutter/material.dart';

class Info6 extends StatelessWidget {
  final String title = '¿Cómo evitar el sedentarismo?'; 
  final String content = '''
El sedentarismo es un estilo de vida caracterizado por una actividad física mínima, que puede tener graves consecuencias para la salud. Pasar largos períodos de tiempo sentado, ya sea en el trabajo, frente al televisor o utilizando dispositivos electrónicos, se ha asociado con un aumento en el riesgo de desarrollar enfermedades crónicas como diabetes tipo 2, hipertensión y enfermedades cardiovasculares.

La buena noticia es que evitar el sedentarismo no requiere grandes cambios o ejercicios intensos. Pequeñas modificaciones en tu rutina diaria pueden marcar una gran diferencia:

Levántate cada 30-60 minutos: Si trabajas muchas horas sentado, intenta levantarte, estirarte o dar una caminata corta. Incluso caminar alrededor de la casa o la oficina puede ser suficiente para activar la circulación.

Incorpora actividad física a tu día: Si no tienes tiempo para hacer ejercicio formal, puedes hacerlo en pequeñas dosis. Usa las escaleras en lugar del ascensor, camina o anda en bicicleta para desplazarte, o dedica 10 minutos al día a estiramientos o yoga.

Haz ejercicio socialmente: Invita a tus amigos o familiares a hacer caminatas, salir a correr o practicar deportes juntos. Esto te ayudará a mantener la motivación.

Realiza tareas cotidianas activamente: Limpiar la casa, jardinería o actividades similares también son maneras de mantenerte en movimiento mientras realizas tus obligaciones.

Evitar el sedentarismo es esencial para mantener una buena salud física y mental. No se trata de hacer ejercicio de manera intensa, sino de ser más activo y moverse con regularidad durante el día.

Cada pequeño esfuerzo cuenta, y moverse más puede transformar tu bienestar. ¡Levántate y empieza a moverte hoy mismo!
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [

            Container(
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xFF1E6459),
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
                    top: 90,
                    left: 30,
                    right: 30, 
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2, 
                      textAlign: TextAlign.left,
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
                'assets/11.png', 
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
