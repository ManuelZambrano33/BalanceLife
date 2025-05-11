import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/sueno_provider.dart';
import 'package:provider/provider.dart';

class ProgramAlarmPage extends StatefulWidget {
  const ProgramAlarmPage({super.key});

  @override
  _ProgramAlarmPageState createState() => _ProgramAlarmPageState();
}

class _ProgramAlarmPageState extends State<ProgramAlarmPage> {
  TimeOfDay? _selectedTime;
  int? _selectedIndex;

  String _formatDuration(double horas) {
    final totalMinutes = (horas * 60).round();
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;

    if (m == 0) return '$h horas';
    return '$h horas con $m minutos';
  }

  List<Map<String, dynamic>> _calculateAlarms(TimeOfDay sleepTime) {
    const int minutesInCycle = 90;
    const int additionalMinutes = 30;
    List<Map<String, dynamic>> alarms = [];

    final now = DateTime.now();

    for (int i = 0; i < 3; i++) {
      int cycles = 4 + i;
      int totalMinutes = cycles * minutesInCycle + additionalMinutes;
      DateTime base = DateTime(now.year, now.month, now.day, sleepTime.hour, sleepTime.minute);
      DateTime newTime = base.add(Duration(minutes: totalMinutes));

      alarms.add({
        'time': TimeOfDay(hour: newTime.hour, minute: newTime.minute),
        'duration': cycles * 90 / 60.0, // duración en horas
      });
    }

    return alarms;
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
                  'Programar Alarma',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset('assets/Programa_Alarma.png', width: 280, height: 280),
          if (_selectedTime == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: const Text('Selecciona la hora de dormir'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedTime = picked);
                  }
                },
              ),
            ),
          if (_selectedTime != null)
            ..._calculateAlarms(_selectedTime!).asMap().entries.map((entry) {
              final index = entry.key;
              final alarm = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() => _selectedIndex = index);

                    await sleepProvider.registrarSueno(
                      usuarioId: 1,
                      duracionHoras: alarm['duration'],
                      fecha: DateTime.now(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sueño registrado")),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? const Color(0xFFBFD7ED) // seleccionado
                          : const Color(0xF5EFF7FD), // no seleccionado
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: ListTile(
                      title: Text('Alarma a las: ${alarm['time'].format(context)}'),
                      subtitle: Text('Horas de sueño: ${_formatDuration(alarm['duration'])}'),
                      trailing: Icon(
                        Icons.check_circle,
                        color: _selectedIndex == index ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
