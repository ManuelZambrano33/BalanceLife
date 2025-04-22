import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/change_password_viewmodel.dart';
 
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  final int? userId;

  const ChangePasswordView({super.key, this.userId});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChangePasswordViewModel>(context);

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
                      'Cambiar Contraseña',
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

            // Formulario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (viewModel.error != null)
                      Text(viewModel.error!, style: const TextStyle(color: Colors.red)),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Nueva Contraseña'),
                      validator: (value) =>
                          value != null && value.length >= 6 ? null : 'Mínimo 6 caracteres',
                    ),
                    TextFormField(
                      controller: _confirmController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Confirmar Contraseña'),
                      validator: (value) =>
                          value == _passwordController.text ? null : 'No coincide',
                    ),
                    const SizedBox(height: 20),
                    viewModel.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF720455),  
                              foregroundColor: Colors.white, 
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (widget.userId != null) {
              await viewModel.changePassword(widget.userId!, _passwordController.text);
              if (viewModel.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contraseña cambiada exitosamente')),
                );
                Navigator.pop(context);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error: usuario no encontrado')),
              );
            }
          }
        },
        child: const Text('Guardar'),
      ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
