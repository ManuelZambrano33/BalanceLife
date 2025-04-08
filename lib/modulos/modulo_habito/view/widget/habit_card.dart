import 'package:flutter/material.dart';
import '../../model/habit_model.dart';
import '../habit_detail_view.dart'; // Asegúrate de importar la vista de detalle
import 'habit_days_selector.dart';
import 'habit_completion_button.dart';

class HabitCard extends StatelessWidget {
  final HabitModel habit;

  HabitCard({required this.habit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitDetailView(habit: habit),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Parte izquierda: texto y días
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre del hábito
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            habit.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        HabitCompletionButton(habit: habit),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Días de la semana
                    HabitDaysSelector(selectedDays: habit.days),
                    SizedBox(height: 8),
                    // Estado completado (opcional, estilo más limpio)
                    Text(
                      habit.done ? 'Completado' : '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // Imagen a la derecha
              SizedBox(width: 12),
              Container(
                width: 60,
                height: 60,
                child: Image.asset(
                  'assets/${habit.category.name}.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 40, color: Colors.grey[400]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
