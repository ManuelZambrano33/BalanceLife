import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/logro_viewmodel.dart';

class LogroPage extends StatefulWidget {
  const LogroPage({super.key});

  @override
  _LogroPageState createState() => _LogroPageState();
}

class _LogroPageState extends State<LogroPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LogroViewModel>(context, listen: false).cargarLogros();
  }

  void mostrarNotificacion(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
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
                  'Logros',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned(
                top: 60,
                right: 10,
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Image.asset('assets/logro.png', fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),

      
      body: Consumer<LogroViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 60), 
            child: ListView.builder(
              itemCount: viewModel.logros.length,
              itemBuilder: (context, index) {
                final logro = viewModel.logros[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Opacity(
                    opacity: logro.estado ? 1.0 : 0.5, 
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
                          logro.descripcion,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text("Puntos: ${logro.puntosGanados}"),
                        trailing: logro.estado
                          ? Image.asset('assets/locked_icon.jpg', width: 40, height: 40)
                          : null,
                        onTap: () {
                          if (!logro.estado) {
                            viewModel.desbloquearLogro(logro.id);
                            mostrarNotificacion("¡Logro desbloqueado!");
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
