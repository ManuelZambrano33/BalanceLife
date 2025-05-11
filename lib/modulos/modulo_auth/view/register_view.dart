import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/user_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Controladores para los campos de texto
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fechaNacimientoController = TextEditingController();

  DateTime? fechaNacimiento;
  bool isEmailValid = true; // Variable para verificar si el correo es válido

  // Función para abrir el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: fechaNacimiento ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        fechaNacimiento = selectedDate;
        fechaNacimientoController.text = "${fechaNacimiento!.toLocal()}".split(' ')[0]; // Formato YYYY-MM-DD
      });
    }
  }

  // Validación de campos
  bool _validateFields() {
    if (nombreController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || fechaNacimientoController.text.isEmpty) {
      return false;
    }
    return true;
  }

  // Mostrar un diálogo de advertencia
  void _showValidationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Campos incompletos'),
          content: const Text('Por favor, completa todos los campos antes de continuar.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Verificar si el correo es válido
  void _checkEmailValidation(String email) {
    // Expresión regular para validar el formato del correo
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    setState(() {
      isEmailValid = emailRegex.hasMatch(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Imagen superior izquierda
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/superior_izquierda.png',
              width: 230,
            ),
          ),

          // Imagen inferior derecha
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/inferior_derecha.png',
              width: 230,
            ),
          ),

          // Contenido principal (Formulario)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'REGISTRARSE',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8E24AA),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de correo electrónico con validación
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        // Mostrar mensaje de error si el correo no es válido
                      ),
                      onChanged: _checkEmailValidation, // Verificar en tiempo real
                    ),
                    const SizedBox(height: 5),
                    // Si el correo es inválido, mostramos un mensaje de error
                    if (!isEmailValid)
                      const Text(
                        'Debe ser un correo válido',
                        style: TextStyle(
                          color: Color.fromARGB(255, 235, 125, 117),
                          fontSize: 12,
                        ),
                      ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo para la fecha de nacimiento
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: fechaNacimientoController,
                          decoration: InputDecoration(
                            labelText: 'Fecha de nacimiento',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 138, 43, 155),
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (!_validateFields() || !isEmailValid) {
                          _showValidationDialog();
                          return;
                        }

                        // Recuperamos los valores de los campos
                        String nombre = nombreController.text;
                        String email = emailController.text;
                        String password = passwordController.text;
                        String fechaNacimientoStr = fechaNacimiento != null
                            ? fechaNacimiento!.toIso8601String().split("T")[0] // Solo la fecha
                            : '';

                        // Llamamos a la función de registro desde UserProvider
                        bool result = await UserProvider.register(
                          nombre,
                          email,
                          password,
                          fechaNacimientoStr,
                        );

                        if (result) {
                          // Si el registro es exitoso, navegamos o mostramos un mensaje
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registro exitoso')),
                          );
                            Navigator.pushReplacementNamed(context, '/homeView');
                        } else {
                          // Si el registro falla, mostramos un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error en el registro')),
                          );
                        }
                      },
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '¿Ya tienes cuenta? Inicia sesión aquí',
                        style: TextStyle(
                          color: Color(0xFF8E24AA),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
