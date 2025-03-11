import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.width,
    required this.height,
    this.borderRadius = 30.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(

          // Resuelve el color de fondo en función del estado del botón.

          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {

                // Cuando el mouse pasa por encima se aclara el color del botón
                return color.withOpacity(0.8);
              }
              // Estado normal
              return color;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 16),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
