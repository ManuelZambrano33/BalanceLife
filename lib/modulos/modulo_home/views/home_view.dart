import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar%20.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import 'widgets/habit_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final firstColumnHabits = viewModel.habits.sublist(0, 3);
    final secondColumnHabits = viewModel.habits.sublist(3);

    return Scaffold(
      body: Stack(
        children: [
          // Nubes de fondo
          Positioned(
            top: 120,
            child: SvgPicture.asset(
              'assets/nubes.svg',
              fit: BoxFit.fitWidth, 
            ),
          ),

          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/Rectangle.svg',
              fit: BoxFit.fitWidth,
            ),
          ),

          // Contenido principal
          Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Textos FIJOS
              Padding(
                
                padding: const EdgeInsets.only(top: 75.0, left: 18.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "¡Hola, usuario!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "¿Qué hábito quieres trabajar hoy?",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              
              // Área SCROLLABLE de las tarjetas
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: firstColumnHabits
                                .map((habit) => HabitCard(habit: habit))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: secondColumnHabits
                                .map((habit) => HabitCard(habit: habit))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),  
    );
  }
}