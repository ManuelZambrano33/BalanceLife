import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/view/acerca_de/acerca_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/config/config_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/info_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/notificaciones/notificaciones_view.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/viewmodel_home.dart';
 
import 'package:provider/provider.dart';


class HomeConfigView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeConfigViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Container(
          height: 190,
          decoration: const BoxDecoration(
            color: Color(0xFF4E5567),
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
                top: 120,
                left: 35,
                child: Text(
                  'Cuenta',
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
      body: homeViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : homeViewModel.errorMessage.isNotEmpty
              ? Center(child: Text(homeViewModel.errorMessage))
              : ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/pfp.jpg'),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeViewModel.userSettings?.name ?? 'Cargando...',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              homeViewModel.userSettings?.email ?? 'Cargando...',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20), 

                    _buildButton('Configuración de cuenta', Icons.settings, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConfigView()),
                      );
                    }),


                    _buildButton('Notificaciones', Icons.notifications, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationView()),
                      );
                    }),
                    _buildButton('Acerca de', Icons.help, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutView()),
                      );
                    }),


                    _buildButton('Información', Icons.info, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InfoView()),);
                    }),
                    SizedBox(height: 380),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: Text('Cerrar Sesión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9C27B0),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildButton(String title, IconData icon, [VoidCallback? onTap]) {
    return SizedBox(
      width: double.infinity, 
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:  Color.fromARGB(0, 218, 211, 211), 
          elevation: 0, 
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey),
                SizedBox(width: 16),
                Text(title),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
