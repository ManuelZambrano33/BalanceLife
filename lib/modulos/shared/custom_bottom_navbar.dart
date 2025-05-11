import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_avatar/view/avatar_view.dart';
import 'package:front_balancelife/modulos/modulo_config/view/home_view.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/menu_estadisticas.dart';
import 'package:front_balancelife/modulos/modulo_home/views/home_view.dart';

class NavBar extends StatelessWidget {
  final int currentPageIndex;

  const NavBar({
    super.key,
    required this.currentPageIndex,
  });

  void _navigateTo(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page =  HomeView();
        break;
        case 1:
          page = MenuEstadisticas();
          break;
        case 2:
          page = AvatarView();
        break;
        case 3:
          page = HomeConfigView();
          break;
      default:
        return;
    }

    if (ModalRoute.of(context)?.settings.name != page.runtimeType.toString()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.analytics), label: 'Estadisticas'),
        NavigationDestination(icon: Icon(Icons.create), label: 'Avatar'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Configuracion'),

      ],
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: currentPageIndex,
      onDestinationSelected: (index) => _navigateTo(context, index),
    );
  }
}