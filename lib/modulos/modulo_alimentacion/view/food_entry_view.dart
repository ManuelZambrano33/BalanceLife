import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/alimentacion_provider.dart';
import 'package:provider/provider.dart';

class FoodEntryView extends StatefulWidget {
  const FoodEntryView({super.key});

  @override
  State<FoodEntryView> createState() => _FoodEntryViewState();
}

class _FoodEntryViewState extends State<FoodEntryView> {
  String? _tipo;
  final _caloriasCtrl = TextEditingController();

  // Tipos de comida disponibles
  final List<String> _tipos = [
    'Desayuno',
    'Almuerzo',
    'Cena',
    'Snack',
  ];

  @override
  void dispose() {
    _caloriasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AlimentacionProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFF437A9D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Positioned(
                    top: 120,
                    left: 35,
                    child: Text(
                      'Alimentación',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 0,
                    child: SizedBox(
                      width: 210,
                      height: 210,
                      child: Image.asset('assets/food.png', fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: const [
                  Text(
                    'Registra la comida de hoy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 32, 66, 87),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _tipo,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                    items: _tipos
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(t),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _tipo = v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _caloriasCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Calorías'),
                  ),
                  const SizedBox(height: 24),
                  prov.isRegistering
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (_tipo == null || _caloriasCtrl.text.isEmpty) return;
                            context.read<AlimentacionProvider>().registrarAlimentacion(
                                  usuarioId: 1, //context.read<AuthProvider>().user!.idUsuario, <---- ESO SE PONE CUANDO ESTE EL LOGIN FUNCIONANDO
                                  tipoComida: _tipo!,
                                  calorias: double.tryParse(_caloriasCtrl.text) ?? 0,
                                  fecha: DateTime.now(),
                                );
                          },
                          child: const Text('Registrar'),
                        ),
                  if (prov.registerError != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      prov.registerError!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (prov.registerSuccess) ...[
                    const SizedBox(height: 12),
                    const Text(
                      '¡Registro exitoso!',
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
