import 'package:flutter/material.dart';

class CustomMenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomMenuButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: 155, // Ancho fijo para el botón
        height: 80, 
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            
            backgroundColor: const Color.fromARGB(255, 214, 230, 249),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
             elevation: 3,  // Aquí se agrega la sombra (de mayor valor, mayor sombra)
             shadowColor: Colors.black, 
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF3F414E),
            ),
            overflow: TextOverflow.visible, // Asegura que el texto se pueda romper en varias líneas
            softWrap: true, 
          ),
        ),
      ),
    );
  }

}