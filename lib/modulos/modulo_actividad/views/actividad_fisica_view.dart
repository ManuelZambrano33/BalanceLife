import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/actividad_fisica_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';

class ActividadFisicaView extends StatefulWidget {
  const ActividadFisicaView({super.key});

  @override
  State<ActividadFisicaView> createState() => _ActividadFisicaViewState();
}

// Solicita permisos de reconocimiento de actividad física
Future<void> solicitarPermisos() async {
  final status = await Permission.activityRecognition.request();
  debugPrint("Estado del permiso: $status");
  if (!status.isGranted) {
    debugPrint("Permiso denegado");
  } else {
    debugPrint("Permiso concedido");
  }
}

class _ActividadFisicaViewState extends State<ActividadFisicaView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await solicitarPermisos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ActividadFisicaViewModel>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo superior
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFFE07A5F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // Texto e imagen en fondo superior
          Positioned(
            top: 140,
            left: 20,
            child: Text(
              'Actividad Física',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: Image.asset(
              'assets/3.png',
              width: 170,
              height: 170,
            ),
          ),
                     

        
          Padding(
            
            padding: const EdgeInsets.only(top: 270),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Recuerda caminar al menos 10000 pasos al día para mantenerte saludable.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Icon(Icons.directions_walk, color: Color(0xFFE07A5F)),
                    title: Text('Pasos', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${viewModel.pasos} pasos'),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Icon(Icons.map, color: Color(0xFFE07A5F)),
                    title: Text('Distancia', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${viewModel.distancia.toStringAsFixed(2)} km'),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE07A5F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    viewModel.guardarActividad(1);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Actividad registrada')),
                    );
                  },
                  child: const Text('Guardar actividad', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 80), // Espacio antes de la nube
              ],
            ),
          ),

          // Nube inferior
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/13.png',
              width: width,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
