import 'package:flutter/material.dart';
import 'nap_page.dart';
import 'sleep_now_page.dart';
import 'program_alarm_page.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});

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
                  'Dormir',
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
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            
            Image.asset(
              'assets/sleep.png', 
              fit: BoxFit.cover, 
              width: MediaQuery.of(context).size.width * 0.6, 
            ),
            
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCard(
                    context,
                    "Siesta",
                    "Programa una alarma de 25 minutos",
                    NapPage(),
                  ),
                  _buildCard(
                    context,
                    "Duerme ahora",
                    "Calcula la hora ideal para despertar",
                    SleepNowPage(),
                  ),
                  _buildCard(
                    context,
                    "Programar alarma",
                    "Elige la hora en la que planeas dormir",
                    ProgramAlarmPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String subtitle, Widget targetPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(245, 126, 175, 213),
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
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          },
        ),
      ),
    );
  }
}
