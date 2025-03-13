import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/water_tracker_viewmodel.dart';

class WaterTrackerView extends StatelessWidget {
  const WaterTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<WaterTrackerViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8E9D2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none, 
                    children: [
                      Positioned(
                        top: 140,
                        left: 35,
                        child: Text(
                          'Hidratación',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F414E),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 10,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset(
                            'assets/hidratacion.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Transform.translate(
                  offset: const Offset(30, 85),
                  child: Image.asset('assets/vaso.png', height: 250),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    clipBehavior: Clip.none, 
                    children: [
                      Positioned(
                        top: 200, 
                        left: 0,  
                        right: 0,
                        child: Image.asset(
                          'assets/nubes.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Vasos de agua: ${viewModel.glasses}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF3F414E),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: viewModel.addGlass,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 248, 231, 231),
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: const Text(
                                'Agregar vaso',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3F414E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
