import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_misiones/viewmodel/misiones_viewmodel.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar%20.dart';
import 'package:provider/provider.dart';

class DesafioView extends StatelessWidget {
  const DesafioView({super.key});

  Icon _getIconForMision(String descripcion) {
    switch (descripcion.toLowerCase()) {
      case 'iniciar sesión':
        return const Icon(Icons.person, color: Color(0xFFFF6B6B), size: 32);
      case 'colocar una alarma':
        return const Icon(Icons.alarm, color: Color(0xFFFF6B6B), size: 32);
      case 'tomar un vaso de agua':
        return const Icon(Icons.water_drop, color: Color(0xFFFF6B6B), size: 32);
      default:
        return const Icon(Icons.task_alt, color: Color(0xFFFF6B6B), size: 32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DesafioViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F4), // Fondo claro cálido
      body: Column(
        children: [
          // Barra superior personalizada
          Container(
            height: 220,
            decoration: const BoxDecoration(
              color: Color(0xFFFFC8C8), // Rosa pálido/coral muy suave
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  top: 145,
                  left: 30,
                  child: Text(
                    'Misiones Diarias',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  right: 10,
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.asset('assets/pana.png', fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Puntos acumulados
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Puntos: ${viewModel.puntos}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Lista de misiones
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.misiones.length,
              itemBuilder: (context, index) {
                final mision = viewModel.misiones[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: _getIconForMision(mision.descripcion),
                    title: Text(
                      mision.descripcion,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "Estado: ${mision.estado}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: ElevatedButton(
                      onPressed: mision.estado == "completado"
                          ? null
                          : () {
                              viewModel.completarMision(mision.id);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B6B), // Coral claro
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFE25E5E), // Coral más oscuro deshabilitado
                        disabledForegroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        mision.estado == "completado" ? "Completado" : "Completar",
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),  
    );
  }
}
