import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/food_entry_viewmodel.dart';

class FoodEntryView extends StatelessWidget {
  const FoodEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FoodEntryViewModel>();
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
                    value: vm.tipo,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                    items: vm.tipos
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(t),
                            ))
                        .toList(),
                    onChanged: vm.setTipo,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cantidad'),
                    onChanged: vm.setCantidad,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Calorías'),
                    onChanged: vm.setCalorias,
                  ),
                  const SizedBox(height: 24),
                  vm.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: vm.registerEntry,
                          child: const Text('Registrar'),
                        ),
                  if (vm.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      vm.error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (vm.success) ...[
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
