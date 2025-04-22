import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_sleep/viewmodel/sleep_viewmodel.dart';
import 'package:provider/provider.dart';

import '../repo/notification_service.dart'; // Importa el servicio de notificaciones

class NapPage extends StatefulWidget {
  @override
  _NapPageState createState() => _NapPageState();
}

class _NapPageState extends State<NapPage> {
  @override
  void initState() {
    super.initState();
    NotificationService.initialize(); // Inicializa las notificaciones una vez
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SleepViewModel>(context, listen: false);
    final napTime = viewModel.obtenerHoraSiesta();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
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
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: -55,
                right: 30,
                child: SizedBox(
                  width: 330,
                  height: 330,
                  child: Image.asset(
                    'assets/luna.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 35,
                child: Text(
                  'Siesta',
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: ListView(
          children: [
            SizedBox(
              width: 300, // o el ancho que quieras
              height: 300,
              child: Image.asset(
                'assets/Siesta.png',
                fit: BoxFit.contain, // o cover si prefieres
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xF5EFF7FD),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    "Despierta en 25 minutos",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    "Hora: ${napTime.hour.toString().padLeft(2, '0')}:${napTime.minute.toString().padLeft(2, '0')}",
                  ),
                  leading: Icon(Icons.alarm, color: Colors.indigo),
                  onTap: () async {
                    await NotificationService.scheduleNapNotification(napTime);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Alarma programada para la siesta 💤"),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
