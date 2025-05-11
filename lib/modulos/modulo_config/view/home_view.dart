import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/view/acerca_de/acerca_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/config/config_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/informacion/info_view.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/viewmodel_home.dart';
import 'package:front_balancelife/modulos/modulo_avatar/view_model/avatar_viewmodel.dart';
import 'package:front_balancelife/modulos/shared/custom_bottom_navbar.dart';
import 'package:front_balancelife/services/auth_service.dart';
import 'package:front_balancelife/services/sharedpreference_service.dart';
import 'package:provider/provider.dart';

class HomeConfigView extends StatelessWidget {
  const HomeConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 3;
    final homeViewModel = Provider.of<HomeConfigViewModel>(context);
    final avatarVM = Provider.of<AvatarViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Positioned(
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
          ? const Center(child: CircularProgressIndicator())
          : homeViewModel.errorMessage.isNotEmpty
              ? Center(child: Text(homeViewModel.errorMessage))
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        // Cambié la posición del avatar aquí
                        Container(
                          width: 60,
                          height: 72,
                          child: Stack(
                            children: [
                              Image.asset(avatarVM.selectedSkin.imagePath,
                                  width: 60, height: 72),
                              Image.asset(avatarVM.selectedShirt.imagePath,
                                  width: 60, height: 72),
                              Image.asset(avatarVM.selectedPants.imagePath,
                                  width: 60, height: 72),
                              Image.asset(avatarVM.selectedFace.imagePath,
                                  width: 60, height: 72),
                              Image.asset(avatarVM.selectedHair.imagePath,
                                  width: 60, height: 72),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (homeViewModel.userSettings?.name != null)
                              Text(
                                homeViewModel.userSettings!.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            if (homeViewModel.userSettings?.email != null)
                              Text(
                                homeViewModel.userSettings!.email,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildButton('Configuración de cuenta', Icons.settings, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ConfigView()),
                      );
                    }),
                    _buildButton('Acerca de', Icons.help, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutView()),
                      );
                    }),
                    _buildButton('Información', Icons.info, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InfoView()),
                      );
                    }),
                    const SizedBox(height: 330),
                    ElevatedButton(
                      onPressed: () async{
                        print(
                          "Cerrando sesión y eliminando datos del usuario",
                        );
                        await SharedPreferencesService().clearUserData();
                        await AuthService().deleteSessionToken();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E5567),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Cerrar Sesión'),
                    ),
                  ],
                ),
      bottomNavigationBar: NavBar(
        currentPageIndex: currentPageIndex,
      ),
    );
  }

  Widget _buildButton(String title, IconData icon, [VoidCallback? onTap]) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(0, 218, 211, 211),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey),
                const SizedBox(width: 16),
                Text(title),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
