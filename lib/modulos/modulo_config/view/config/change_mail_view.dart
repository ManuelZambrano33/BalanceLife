import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/change_mail_viewmodel.dart';
 
import 'package:provider/provider.dart';
class ChangeMailView extends StatefulWidget {
  final int? userId;

  const ChangeMailView({super.key, this.userId});

  @override
  State<ChangeMailView> createState() => _ChangeMailViewState();
}

class _ChangeMailViewState extends State<ChangeMailView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChangeMailViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Correo'),
        backgroundColor: const Color(0xFF720455),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Ingresa tu nuevo correo electrónico',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Nuevo correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un correo';
                  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                    return 'Por favor ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmEmailController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != _emailController.text) {
                    return 'Los correos no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          await viewModel.changeMail(
                            widget.userId!,
                            _emailController.text,
                          );

                          if (viewModel.success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Correo actualizado')),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error al actualizar correo')),
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF720455),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: viewModel.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Cambiar correo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
