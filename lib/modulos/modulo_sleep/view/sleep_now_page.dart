import 'package:flutter/material.dart';

class SleepNowPage extends StatelessWidget {
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
                  'Duerme Ahora',
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
        child: ListView(
          children: [
             SizedBox(
              width: 260, // o el ancho que quieras
              height: 260,
              child: Image.asset(
                'assets/Duerme_Ahora.png',
                fit: BoxFit.contain, // o cover si prefieres
              ),
            ),
            _buildCard("Despierta después de 4 ciclos", "Hora calculada"),
            _buildCard("Despierta después de 5 ciclos", "Hora calculada"),
            _buildCard("Despierta después de 6 ciclos", "Hora calculada"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle) {
    return Padding(
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
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
