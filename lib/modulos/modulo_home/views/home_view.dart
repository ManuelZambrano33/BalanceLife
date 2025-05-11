import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_balancelife/modulos/modulo_avatar/view_model/avatar_viewmodel.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import 'widgets/habit_card.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final viewModel = Provider.of<HomeViewModel>(context);
    final firstColumnHabits = viewModel.habits.sublist(0, 3);
    final secondColumnHabits = viewModel.habits.sublist(3);
    
    // Obtener el AvatarViewModel para acceder a las diferentes partes del avatar
    final avatarVM = Provider.of<AvatarViewModel>(context);
    
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
                    Row(
                      children: [
                        // Avatar pequeño dentro de la bolita
                        CircleAvatar(
                          radius: 25, // Ajusta el tamaño del avatar en la bolita
                          backgroundColor: Colors.transparent, // Fondo transparente
                          child: ClipOval(
                            child: Stack(
                              children: [
                                // Piel del avatar
                                Image.asset(avatarVM.selectedSkin.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                                // Camisa del avatar
                                Image.asset(avatarVM.selectedShirt.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                                // Pantalones del avatar
                                Image.asset(avatarVM.selectedPants.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                                // Cara del avatar
                                Image.asset(avatarVM.selectedFace.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                                // Cabello del avatar
                                Image.asset(avatarVM.selectedHair.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "¡Hola, Bienvenido!",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
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
      bottomNavigationBar: NavBar(
        currentPageIndex: currentIndex,
      ),
    );
  }
}
