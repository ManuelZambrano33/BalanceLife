import 'package:flutter/material.dart';

class ProgramAlarmPage extends StatefulWidget {
  @override
  _ProgramAlarmPageState createState() => _ProgramAlarmPageState();
}

class _ProgramAlarmPageState extends State<ProgramAlarmPage> {
  TimeOfDay? _selectedTime;

  List<TimeOfDay> _calculateAlarms(TimeOfDay sleepTime) {
    int minutesInCycle = 90; 
    int additionalMinutes = 30; 

    List<TimeOfDay> alarms = [];
    for (int cycles in [4, 5, 6]) {
      int totalMinutes = cycles * minutesInCycle + additionalMinutes;
      DateTime newTime = DateTime(2025, 4, 16, sleepTime.hour, sleepTime.minute)
          .add(Duration(minutes: totalMinutes));
      alarms.add(TimeOfDay(hour: newTime.hour, minute: newTime.minute));
    }

    return alarms;
  }

  @override
  Widget build(BuildContext context) {
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
                  'Programar Alarma',
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
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 280,
              height: 280,
              child: Image.asset(
                'assets/Programa_Alarma.png',
                fit: BoxFit.contain,
              ),
            ),

            // Botón para seleccionar la hora de dormir
            if (_selectedTime == null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
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
                      'Selecciona la hora de dormir',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedTime = picked;
                        });
                      }
                    },
                  ),
                ),
              ),

            // Mostrar alarmas después de seleccionar la hora
            if (_selectedTime != null) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Alarmas programadas:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ..._calculateAlarms(_selectedTime!).map(
                (alarmTime) => Padding(
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
                      title: Text('Alarma a las: ${alarmTime.format(context)}'),
                      trailing: Icon(Icons.alarm),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
