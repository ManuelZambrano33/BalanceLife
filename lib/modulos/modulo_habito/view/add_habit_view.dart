import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';
import '../view_model/habit_view_model.dart';
import '../model/habit_model.dart';
import '../model/enum/habit_enums.dart';

class AddHabitView extends StatefulWidget {
  const AddHabitView({super.key});

  @override
  _AddHabitViewState createState() => _AddHabitViewState();
}

class _AddHabitViewState extends State<AddHabitView> {
  final _nameController = TextEditingController();
  int selectedCategoryIndex = 0;
  List<bool> selectedDays = List.generate(7, (_) => false);
  HabitReminder selectedReminder = HabitReminder.manana;

  @override
  Widget build(BuildContext context) {
    final habitViewModel = Provider.of<HabitViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
         child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF9A91B4), // Color cambiado a 0xFF9A91B4
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 40),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Añadir hábito',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'assets/habit.png',
                          height: 180,
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Campo de texto del nombre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildTextField('Nombre del hábito', _nameController),
            ),

            SizedBox(height: 32),

            // Selector de categoría
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  _buildCategorySelector(),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Selector de días
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Días", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  _buildDaysSelector(),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Selector de recordar en
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recordar en", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  _buildReminderSelector(),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Botón de añadir hábito
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  final newHabit = HabitModel(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    category: HabitCategory.values[selectedCategoryIndex],
                    days: selectedDays,
                    done: false,
                    reminder: selectedReminder,
                  );
                  habitViewModel.addHabit(newHabit);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9A91B4), // Color cambiado a 0xFF9A91B4
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                ),
                child: Center(
                  child: Text(
                    'Añadir hábito',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

Widget _buildCategorySelector() {
  final viewModel = Provider.of<HomeViewModel>(context);
  
  return Row( 
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(viewModel.habits.length - 1, (index) {
      bool isSelected = selectedCategoryIndex == index;
      
      return GestureDetector(
        onTap: () => setState(() => selectedCategoryIndex = index),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:  Color(0xFF9A91B4), // Fondo morado para todos
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 4))] // Sombra cuando es seleccionado
                : [], // Sin sombra cuando no está seleccionado
          ),
          child: Image.asset(
            viewModel.habits[index].iconPath.replaceAll('.svg', '.png'), // Cambiar la extensión a .png
            height: 50, 
            width: 50,
          ),
        ),
      );
    }),
  );
}


  Widget _buildDaysSelector() {
    final days = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDays[index] = !selectedDays[index];
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: selectedDays[index] ? Color(0xFF9A91B4) : Colors.white, // Color cambiado a 0xFF9A91B4
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
            ),
            alignment: Alignment.center,
            child: Text(
              days[index],
              style: TextStyle(
                color: selectedDays[index] ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildReminderSelector() {
    final options = {
      HabitReminder.manana: 'Mañana',
      HabitReminder.tarde: 'Tarde',
      HabitReminder.noche: 'Noche',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.entries.map((entry) {
        final isSelected = selectedReminder == entry.key;

        return GestureDetector(
          onTap: () => setState(() => selectedReminder = entry.key),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF9A91B4) : Colors.white, // Color cambiado a 0xFF9A91B4
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              entry.value,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
