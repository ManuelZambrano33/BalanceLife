import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/theme_repository.dart';
import 'package:front_balancelife/modulos/modulo_config/view/config/change_password_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/config/delete_account_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/config/disable_biometric_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/config/theme_view.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/change_password_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/delete_account_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/theme_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigView extends StatelessWidget {
  const ConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Positioned(
                    top: 110,
                    left: 30,
                    child: Text(
                      'Configuración de cuenta',
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

            const SizedBox(height: 50),

            _buildButton('Actualizar datos', Icons.lock , () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => ChangePasswordViewModel(),
                            child: const UpdateUserView(),
                          ),
                        ),
                      );
                    }),

            // _buildButton('Cambiar Tema (Claro/Oscuro)', Icons.brightness_6, () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ChangeNotifierProvider(
            //         create: (_) => ThemeViewModel(ThemeRepository()),
            //         child: const ThemeView(),
            //       ),
            //     ),
            //   );
            // }),

            _buildButton('Eliminar Cuenta', Icons.delete, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => DeleteAccountViewModel(),
                            child: const DeleteAccountView(),
                          ),
                        ),
                      );
                    }),


            // Nuevo botón para deshabilitar el inicio con huella
            _buildButton('Deshabilitar inicio con huella', Icons.fingerprint, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DisableBiometricView(),
                ),
              ); 
            }),
          ],
        ),
      ),
    );
  }

  // Función para deshabilitar el inicio de sesión con huella
  Future<void> _disableBiometricLogin(BuildContext context) async {
    final storage = FlutterSecureStorage();

    // Eliminar el token de sesión largo (o cualquier dato relacionado con la huella)
    await storage.delete(key: 'longLivedToken');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inicio de sesión con huella deshabilitado.')),
    );
  }

  Widget _buildButton(String title, IconData icon, [VoidCallback? onTap]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap ?? () {
            print('$title presionado');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(0, 218, 211, 211),  
            elevation: 0, 
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.grey),
                  const SizedBox(width: 16),
                  Text(
                    title,
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
