import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricConfirmationDialog extends StatefulWidget {
  @override
  _BiometricConfirmationDialogState createState() => _BiometricConfirmationDialogState();
}

class _BiometricConfirmationDialogState extends State<BiometricConfirmationDialog> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _statusMessage = '';

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
      _statusMessage = 'Por favor autentícate con tu huella';
    });

    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Confirma tu identidad para continuar',
        options: AuthenticationOptions(biometricOnly: true),
      );

      Navigator.pop(context, authenticated);
    } catch (e) {
      setState(() => _statusMessage = 'Error: ${e.toString()}');
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context, false);
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fingerprint,
              size: 48,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'Confirmación Biométrica',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            if (_isAuthenticating) ...[
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                _statusMessage,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}