import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_balancelife/Provider/user_provider.dart';
import 'package:front_balancelife/modulos/modulo_auth/view/biometric_confirmation_dialog%20copy.dart';
import 'package:front_balancelife/services/auth_service.dart';
import 'package:local_auth/local_auth.dart';
import 'biometric_confirmation_dialog.dart'; // Asegúrate de tener este archivo

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = FlutterSecureStorage();
  bool _showBiometricButton = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricStatus();
  }

  Future<void> _checkBiometricStatus() async {
    final token = await AuthService().readToken();
    print("Token encontrado: $token");
    if (token == null) {
      setState(() => _showBiometricButton = false);
    } else {
      setState(() => _showBiometricButton = true);
    }
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Por favor completa todos los campos');
      return;
    }

    final success = await UserProvider.loginUser(email, password);
    print("Login success: $success");
    if (success) {
      final longToken = await AuthService().readToken();
      print("Long Token: $longToken");
      if (longToken == null) {
        _showEnableBiometricDialog(email);
      } else {
        _navigateToHome();
      }
    } else {
      _showSnackbar('Credenciales incorrectas');
    }
  }

  void _showEnableBiometricDialog(String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Habilitar Huella Digital'),
        content: const Text('¿Deseas habilitar el inicio de sesión con huella digital?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => BiometricConfirmationDialog(),
              );
              
              if (confirmed ?? false) {
                _validateCredentialsForBiometric(email);
              }
            },
            child: const Text('Habilitar'),
          ),
        ],
      ),
    );
  }

  Future<void> _validateCredentialsForBiometric(String email) async {
    final isValid = await showDialog<bool>(
      context: context,
      builder: (context) => CredentialValidationDialog(
        email: email,
        password: _passwordController.text,
      ),
    );
    print("Validación de credenciales PARA GENERAR EL LONG TOKEN: $isValid");
    if (isValid ?? false) {
      await _enableBiometricAuthentication(email);
    }
  }

  Future<void> _enableBiometricAuthentication(String email) async {
    try {
      final success = await UserProvider.habilitarHuella(email);
      print("SI LLEGA A Habilitar huella success???: $success");
      if (success) {
        setState(() => _showBiometricButton = true);
        _navigateToHome();
      }
    } catch (e) {
      _showSnackbar('Error al configurar huella: $e');
    }
  }

  Future<void> _handleBiometricLogin() async {
    try {
      final longToken = await AuthService().readToken();
      if (longToken == null) return;

      final authenticated = await showDialog<bool>(
        context: context,
        builder: (context) => BiometricConfirmationDialog(),
      );

      if (authenticated ?? false) {
        final newToken = await UserProvider.verifyLongToken(longToken);
        if (newToken != null) {
          _navigateToHome();
        }
      }
    } catch (e) {
      _showSnackbar('Error de autenticación: $e');
    }
  }

  void _navigateToHome() {
    print("Navegando a la vista de inicio");
    Navigator.pushReplacementNamed(context, '/homeView');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/superior_izquierda.png', width: 230),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/inferior_derecha.png', width: 230),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'INICIAR SESIÓN',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8E24AA),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock),
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
                      onPressed: _handleLogin,
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_showBiometricButton)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.fingerprint),
                        label: const Text('Usar huella digital'),
                        onPressed: _handleBiometricLogin,
                      ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: const Text(
                        '¿No tienes cuenta? Regístrate aquí',
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
