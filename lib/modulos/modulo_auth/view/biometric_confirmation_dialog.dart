import 'package:flutter/material.dart';

class CredentialValidationDialog extends StatefulWidget {
  final String email;
  final String password;

  const CredentialValidationDialog({
    required this.email,
    required this.password,
  });

  @override
  _CredentialValidationDialogState createState() =>
      _CredentialValidationDialogState();
}

class _CredentialValidationDialogState extends State<CredentialValidationDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Validar Credenciales'),
      content: SizedBox(
        width: 300, // Ajusta el tamaño de la caja según lo que necesites
        child: Column(
          mainAxisSize: MainAxisSize.min, // Esto asegura que el Column ocupe solo el espacio necesario
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16), // Espaciado entre los campos
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {

            final isValid = _emailController.text == widget.email &&
                            _passwordController.text == widget.password;

            if (isValid) {
              Navigator.pop(context, true); // Cierra el diálogo y pasa true
            } else {
              // Muestra un SnackBar con el mensaje de error y color rojo
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('¡Credenciales incorrectas!'),
                  backgroundColor: Colors.red, // Fondo rojo para el SnackBar
                ),
              );
              Navigator.pop(context, false); // Cierra el diálogo y pasa false
            }
          },
          child: const Text('Validar'),
        ),
      ],
    );
  }
}
