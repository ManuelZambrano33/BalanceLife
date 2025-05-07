import 'package:flutter/material.dart';

class Info5 extends StatelessWidget {
  final String title = ' ¿Qué son los ciclos circadianos?'; 
  final String content = '''
Los ciclos circadianos son los ritmos biológicos naturales de tu cuerpo que siguen un ciclo de 24 horas, regulando funciones esenciales como el sueño, la temperatura corporal, la liberación de hormonas, el hambre y el estado de ánimo. Estos ciclos están influenciados principalmente por la luz natural del día y la oscuridad de la noche, lo que ayuda a tu cuerpo a ajustarse a un horario regular.

El ciclo circadiano está controlado por el reloj biológico en el cerebro, específicamente en una parte llamada el núcleo supraquiasmático, que responde a los cambios de luz. Cuando la luz disminuye, tu cuerpo libera melatonina, la hormona que induce el sueño, ayudándote a descansar durante la noche. Por el contrario, la luz durante el día disminuye la producción de melatonina, manteniéndote despierto y alerta.

Alteraciones en los ciclos circadianos, como las que ocurren por trabajo nocturno, jet lag o el uso excesivo de dispositivos electrónicos antes de dormir, pueden tener efectos negativos en la salud. Estos pueden incluir problemas de sueño, aumento del riesgo de enfermedades metabólicas, problemas de concentración e incluso trastornos de ánimo.

Para mantener tus ciclos circadianos en equilibrio, es importante tener horarios regulares de sueño, exponerse a la luz natural durante el día y reducir la exposición a la luz artificial por la noche.

Respetar tus ciclos circadianos es crucial para mejorar la calidad de tu sueño, optimizar tu energía durante el día y prevenir problemas de salud a largo plazo.


''';

  const Info5({super.key});

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
                color: Color(0xFFA83B3B),
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
                'assets/12.png', 
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
