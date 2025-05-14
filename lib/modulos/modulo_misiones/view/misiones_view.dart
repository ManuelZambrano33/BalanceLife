import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/user_provider.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';
import 'package:provider/provider.dart';

class MisionesView extends StatefulWidget {
  const MisionesView({super.key});

  @override
  State<MisionesView> createState() => _MisionesViewState();
}

class _MisionesViewState extends State<MisionesView> {
  final TextEditingController vasosAguaController = TextEditingController();
  final TextEditingController caloriasController = TextEditingController();
  final TextEditingController horasSuenoController = TextEditingController();
  final TextEditingController pasosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int currentIndex = 2;
    return Scaffold(
      body: Column(
        children: [
          // Encabezado visual con imagen
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 92, 168, 249),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              const Positioned(
                top: 145,
                left: 30,
                child: Text(
                  'Misiones',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 80,
                right: 20,
                child: Image.asset(
                  'assets/6.png',
                  width: 170,
                  height: 170,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),
          
           Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 250), // Ajusta este valor a lo angosto que desees
                child: Text(
                  'Establece tus metas y alcanza tus objetivos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic, // Esto hace que el texto esté en cursiva
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),


          // Campos
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  _buildLabeledSelector(
                    context,
                    'Meta diaria de vasos de agua:',
                    vasosAguaController,
                    UserServiceModel.meta_hidratacion!, // 👈 Aquí se usa el nuevo parámetro
                  ),
                  _buildLabeledSelector(
                    context,
                    'Meta diaria de calorías:',
                    caloriasController,
                    UserServiceModel.meta_alimentacion!, // 👈 Aquí se usa el nuevo parámetro
                  ),
                  _buildLabeledSelector(
                    context,
                    'Meta diaria de horas de sueño:',
                    horasSuenoController,
                    UserServiceModel.meta_sueno!, // 👈 Aquí se usa el nuevo parámetro
                  ),
                  _buildLabeledSelector(
                    context,
                    'Meta diaria de pasos:',
                    pasosController,
                    UserServiceModel.meta_deporte!, // 👈 Aquí se usa el nuevo parámetro
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if(vasosAguaController.text.isNotEmpty){
                        UserServiceModel.meta_hidratacion = vasosAguaController.text;
                      }
                      if(caloriasController.text.isNotEmpty){
                        UserServiceModel.meta_alimentacion = caloriasController.text;
                      }
                      if(horasSuenoController.text.isNotEmpty){
                        UserServiceModel.meta_sueno = horasSuenoController.text;
                      }
                      if(pasosController.text.isNotEmpty){
                        UserServiceModel.meta_deporte = pasosController.text;
                      }
                      bool result = await UserProvider.actualizarMetas();
                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Metas actualizadas correctamente'),
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al actualizar las metas'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text('Guardar metas'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentPageIndex: currentIndex,
      ),
    );
  }

  Widget _buildLabeledSelector(BuildContext context, String label, TextEditingController controller, String value_hint_text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: CustomNumberInput(controller: controller, hintText: value_hint_text.toString()), // 👈 Aquí se usa el nuevo parámetro
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    vasosAguaController.dispose();
    caloriasController.dispose();
    horasSuenoController.dispose();
    pasosController.dispose();
    super.dispose();
  }
}

class CustomNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText; // 👈 Nuevo parámetro

  const CustomNumberInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      showCursor: false, 
      decoration: InputDecoration(
        hintText: hintText, // 👈 Aquí se usa
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(137, 74, 73, 73),
        ),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      ),
    );
  }
}
