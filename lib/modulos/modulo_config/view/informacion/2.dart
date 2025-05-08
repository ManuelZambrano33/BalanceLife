import 'package:flutter/material.dart';

class Info2 extends StatelessWidget {
  final String title = 'Tiempo Ideal para Ejercitarse'; 
  final String content = '''
Según la Organización Mundial de la Salud (OMS), se recomienda que los adultos realicen al menos 150 a 300 minutos de actividad física moderada a la semana, o 75 a 150 minutos de actividad intensa. Esto equivale a unos 30 minutos al día, cinco veces por semana.

Este tiempo puede dividirse a lo largo del día en sesiones más cortas, como tres caminatas de 10 minutos. Lo importante es mantenerse activo con regularidad. Para los niños y adolescentes, se recomienda al menos 60 minutos diarios de actividad física.

La clave está en la constancia y en adaptar el ejercicio a tus necesidades y capacidades. No necesitas un gimnasio: caminar, bailar, subir escaleras o andar en bicicleta también cuentan.

Incorporar el ejercicio a tu rutina diaria es una de las decisiones más saludables que puedes tomar.
''';

  const Info2({super.key});

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
                color: Color.fromARGB(255, 231, 79, 59),
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
                'assets/13.png', 
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
