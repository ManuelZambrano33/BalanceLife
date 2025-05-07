import 'package:flutter/material.dart';

class Info3 extends StatelessWidget {
  final String title = 'Importancia del agua para la salud'; 
  final String content = '''
El agua es esencial para la vida, ya que compone aproximadamente el 60% del cuerpo humano. Su papel en nuestra salud es crucial, ya que participa en casi todas las funciones vitales, desde la digestión y circulación hasta la regulación de la temperatura corporal y la eliminación de desechos.

Mantenerse bien hidratado ayuda a mejorar la concentración, el rendimiento físico y el estado de ánimo. Además, el agua es fundamental para la desintoxicación del cuerpo, ya que facilita la eliminación de toxinas a través de la orina y el sudor.

Cada persona necesita diferentes cantidades de agua según factores como el clima, la actividad física y la salud general. Sin embargo, como regla general, se recomienda beber alrededor de 8 vasos de agua al día (aproximadamente 2 litros).

Recuerda que las bebidas como jugos y té también aportan hidratación, pero el agua sigue siendo la opción más saludable y accesible para mantener el equilibrio hídrico.

Tu cuerpo necesita agua para funcionar correctamente. No olvides beber suficiente cada día.
''';

  const Info3({super.key});

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
                color: Color(0xFFC92983),
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
                'assets/9.png', 
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
