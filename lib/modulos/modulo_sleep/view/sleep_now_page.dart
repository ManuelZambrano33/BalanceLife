import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/sueno_provider.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SleepNowPage extends StatefulWidget {
  const SleepNowPage({super.key});

  @override
  State<SleepNowPage> createState() => _SleepNowPageState();
}

class _SleepNowPageState extends State<SleepNowPage> {
  int? selectedCiclo;

  String calcularHoraDespertar(int minutos) {
    final ahora = DateTime.now().add(Duration(minutes: minutos));
    return DateFormat('hh:mm a').format(ahora);
  }

  @override
  Widget build(BuildContext context) {
    final sleepProvider = Provider.of<SleepProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Container(
          height: 190,
          decoration: const BoxDecoration(
            color: Color(0xFF1C2F59),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 45,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: -55,
                right: 30,
                child: Image.asset('assets/luna.png', width: 330, height: 330),
              ),
              const Positioned(
                top: 120,
                left: 35,
                child: Text(
                  'Duerme Ahora',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: [
          Image.asset('assets/Duerme_Ahora.png', width: 260, height: 260),
          ..._buildCards(context, sleepProvider),
        ],
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context, SleepProvider provider) {
    final ciclos = [4, 5, 6];

    return ciclos.map((ciclo) {
      final duracionHoras = ciclo * 90 / 60.0;
      final minutos = ciclo * 90;
      final isSelected = selectedCiclo == ciclo;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          onTap: () async {
            setState(() {
              selectedCiclo = ciclo;
            });

            await provider.registrarSueno(
              usuarioId: UserServiceModel.id_usuario ?? 0,
              duracionHoras: duracionHoras,
              fecha: DateTime.now(),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Sueño registrado"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFD8EAE0) : const Color(0xF5EFF7FD),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
              ],
            ),
            child: ListTile(
              title: Text("Despierta después de $ciclo ciclos"),
              subtitle: Text("Hora: ${calcularHoraDespertar(minutos)}"),
              trailing: Icon(
                isSelected ? Icons.check_circle : Icons.check_circle_outline,
                color: isSelected ? Colors.green : Colors.blueAccent,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
