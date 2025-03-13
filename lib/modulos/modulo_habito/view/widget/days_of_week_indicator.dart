import 'package:flutter/material.dart';

class DaysOfWeekIndicator extends StatelessWidget {
  /// Lista de días seleccionados (p.ej.: ['lunes', 'miercoles', 'viernes']).
  final List<String> selectedDays;

  /// Color de fondo para los días seleccionados.
  final Color selectedColor;

  /// Color de texto para los días seleccionados.
  final Color selectedTextColor;

  /// Color de fondo para los días no seleccionados.
  final Color unselectedColor;

  /// Color de texto para los días no seleccionados.
  final Color unselectedTextColor;

  /// Tamaño del círculo (ancho/alto).
  final double circleSize;

  const DaysOfWeekIndicator({
    super.key,
    required this.selectedDays,
    required this.selectedColor,
    required this.selectedTextColor,
    required this.unselectedColor,
    required this.unselectedTextColor,
    this.circleSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    // Orden de días de la semana y sus abreviaturas (ajusta según tu preferencia).
    // La segunda "M" es para "Miércoles" tal como se ve en tus ejemplos.
    final List<Map<String, String>> daysMap = [
      {'full': 'lunes', 'short': 'L'},
      {'full': 'martes', 'short': 'M'},
      {'full': 'miercoles', 'short': 'M'},
      {'full': 'jueves', 'short': 'J'},
      {'full': 'viernes', 'short': 'V'},
      {'full': 'sabado', 'short': 'S'},
      {'full': 'domingo', 'short': 'D'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: daysMap.map((day) {
        // Determina si este día está seleccionado
        final bool isSelected = selectedDays
            .map((d) => d.toLowerCase())  // Normaliza a minúsculas
            .contains(day['full']);      // Compara con el 'full' del mapa

        // El color y el texto varían según el estado (seleccionado o no)
        final bgColor = isSelected ? selectedColor : unselectedColor;
        final textColor = isSelected ? selectedTextColor : unselectedTextColor;

        return Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            day['short'] ?? '',
            style: TextStyle(
              color: textColor,
              fontSize: 14, // Ajusta si quieres más grande o más pequeño
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}
