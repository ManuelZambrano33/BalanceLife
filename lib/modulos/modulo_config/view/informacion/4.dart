import 'package:flutter/material.dart';

class Info4 extends StatelessWidget {
  final String title = ' ¿Cuánta agua debo beber al día?'; 
  final String content = '''
La cantidad de agua que debemos beber diariamente depende de varios factores, como la edad, el peso, el nivel de actividad física y el clima. Sin embargo, un buen punto de partida es la conocida regla de los 8 vasos de agua al día, lo que equivale a aproximadamente 2 litros.

Sin embargo, algunas personas pueden necesitar más agua. Por ejemplo:

Si eres muy activo: El ejercicio aumenta la pérdida de agua, por lo que es importante rehidratarse después de hacer actividad física.

Clima cálido: Si vives en un lugar caluroso o estás expuesto al sol por largo tiempo, puedes necesitar más líquidos para evitar la deshidratación.

Salud: Si estás enfermo, especialmente si tienes fiebre, vómitos o diarrea, también necesitarás beber más agua para reponer líquidos.

Recuerda que la hidratación no solo depende del agua pura. Los alimentos como frutas y verduras (por ejemplo, sandía, pepino y naranjas) también contribuyen a tu ingesta de líquidos.

Escucha a tu cuerpo: Si sientes sed, es una señal de que necesitas beber más agua. Mantente hidratado para asegurar un buen funcionamiento de tu cuerpo.
''';

  const Info4({super.key});

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
                color: Color(0xFF113F71),
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
                'assets/10.png', 
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
