import 'package:flutter/material.dart';
import 'package:front_balancelife/services/auth_service.dart';

class DisableBiometricView extends StatelessWidget {
  const DisableBiometricView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
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
                      'Deshabilitar inicio con huella',
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    '¿Estás seguro de que deseas deshabilitar el inicio de sesión con huella?',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {                   
                      await AuthService().deleteToken();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Inicio con huella deshabilitado.')),
                      );
                      Navigator.pop(context); // Regresa a la pantalla anterior.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF720455),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Deshabilitar'),
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
