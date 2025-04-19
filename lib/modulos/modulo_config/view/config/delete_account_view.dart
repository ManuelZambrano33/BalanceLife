import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/delete_account_viewmodel.dart';
 
import 'package:provider/provider.dart';

class DeleteAccountView extends StatelessWidget {
  final int? userId;

  const DeleteAccountView({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DeleteAccountViewModel>(context);

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
                      'Eliminar Cuenta',
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

 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    '¿Estás seguro de que deseas eliminar tu cuenta? Esta acción es irreversible.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () async {
                            if (userId != null) {
                              final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Confirmación'),
                                        content: const Text(
                                            '¿Estás seguro de que deseas eliminar tu cuenta?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text('Eliminar'),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false;

                              if (confirm) {
                                await viewModel.deleteAccount(userId!);
                                if (viewModel.success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Cuenta eliminada')),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: ${viewModel.error}')),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Usuario no encontrado')),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF720455),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Eliminar cuenta'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
