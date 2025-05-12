import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/sueno_provider.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';
import 'package:provider/provider.dart';
import '../repo/notification_service.dart';

class NapPage extends StatefulWidget {
  const NapPage({super.key});

  @override
  State<NapPage> createState() => _NapPageState();
}

class _NapPageState extends State<NapPage> {
  @override
  void initState() {
    super.initState();
    NotificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SleepProvider>(context, listen: false);

    final now = DateTime.now();
    final wakeUpTime = now.add(const Duration(minutes: 25));
    final formattedWakeUp = "${wakeUpTime.hour.toString().padLeft(2, '0')}:${wakeUpTime.minute.toString().padLeft(2, '0')}";

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
            clipBehavior: Clip.none,
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
                child: SizedBox(
                  width: 330,
                  height: 330,
                  child: Image.asset('assets/luna.png', fit: BoxFit.contain),
                ),
              ),
              const Positioned(
                top: 120,
                left: 35,
                child: Text(
                  'Siesta',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: ListView(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/Siesta.png', fit: BoxFit.contain),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xF5EFF7FD),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
                  ],
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Despierta en 25 minutos"),
                      const SizedBox(height: 4),
                      Text("⏰ $formattedWakeUp", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await provider.registrarSueno(
                        usuarioId: UserServiceModel.id_usuario ?? 0,
                        duracionHoras: 0.42,
                        fecha: DateTime.now(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Alarma programada para la siesta 💤"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C2F59),
                    ),
                    child: const Text("Registrar", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
