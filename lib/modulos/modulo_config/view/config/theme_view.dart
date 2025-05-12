import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFF720455), 
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Positioned(
                    top: 110,
                    left: 30,
                    child: Text(
                      'Tema',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Modo oscuro',
                    style: TextStyle(fontSize: 18),
                  ),
                 // En ThemeView.dart
                  Consumer<ThemeViewModel>(
                    builder: (context, themeViewModel, _) {
                      return Switch(
                        value: themeViewModel.isDarkMode,
                        onChanged: (value) => themeViewModel.toggleTheme(),
                      );
                    },
                  ),  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
