import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeMiniJuegosView extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();  

  HomeMiniJuegosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF3F7D58),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 120,
                  left: 35,
                  child: Text(
                    'Minijuegos',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset('assets/games.png', fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 200),


          ElevatedButton(
            onPressed: () => viewModel.irAlMinijuego1(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF9651),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              minimumSize: const Size(280, 70),
              elevation: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(-10, 0), 
                  child: Image.asset(
                    'assets/tomato.png',
                    height: 70,
                    width: 70,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Healthy Match',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),


          const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => viewModel.irAlMinijuego2(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC5228),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                minimumSize: const Size(280, 70),
                elevation: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.translate(
                    offset: const Offset(-10, 0), 
                    child: Image.asset(
                      'assets/pera.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Fruit Rush        ',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),


          const SizedBox(height: 30),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavBar(),  

    );
  }
}
