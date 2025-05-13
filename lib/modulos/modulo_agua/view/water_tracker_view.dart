import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/hidratacion_provider.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';

class WaterTrackerView extends StatefulWidget {
  const WaterTrackerView({super.key});

  @override
  State<WaterTrackerView> createState() => _WaterTrackerViewState();
}

class _WaterTrackerViewState extends State<WaterTrackerView> {
  final _cantidadCtrl = TextEditingController();
  bool _isRegistering = false;

  @override
  void dispose() {
    _cantidadCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardarHidratacion() async {
    final input = int.tryParse(_cantidadCtrl.text);
    if (input == null || input <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa una cantidad válida')),
      );
      return;
    }

    setState(() {
      _isRegistering = true;
    });

    try {


      await HidratacionProvider.registrarHidratacion(
        cantidad: input,
        fecha: DateTime.now(),
        usuarioId: UserServiceModel.id_usuario!,
      );

      _cantidadCtrl.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Registro exitoso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isRegistering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                children: [
                  const Positioned(
                    bottom: 16,
                    left: 24,
                    child: Text(
                      'Hidratación',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F414E),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 24,
                    child: Image.asset(
                      'assets/hidratacion.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: Image.asset(
                'assets/vaso.png',
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                controller: _cantidadCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad (Vasos)',
                  filled: true,
                  fillColor: const Color(0xFFEDEDED),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xFFF8E9D2),
                      width: 2,
                    ),
                  ),
                  prefixIcon:
                      const Icon(Icons.local_drink, color: Color(0xFF3F414E)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: _isRegistering ? null : _guardarHidratacion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF8E9D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isRegistering
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF3F414E),
                        ),
                      )
                    : const Text(
                        'Guardar',
                        style: TextStyle(fontSize: 18, color: Color(0xFF3F414E)),
                      ),
              ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/nubes.png',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
