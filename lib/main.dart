import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/menu_estadisticas.dart';
import 'package:front_balancelife/modulos/modulo_logros/view/logro_page.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/view/fruit_game_view.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/view/memory_game_view.dart';
import 'package:provider/provider.dart';
import 'package:front_balancelife/modulos/modulo_home/viewmodels/home_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_home/views/home_view.dart';
import 'package:front_balancelife/modulos/modulo_agua/repo/water_tracker_repository.dart';
import 'package:front_balancelife/modulos/modulo_agua/view_model/water_tracker_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_agua/view/water_tracker_view.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/viewmodels/stats_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/stat_view.dart';
import 'package:front_balancelife/modulos/modulo_habito/view_model/habit_view_model.dart';
import 'package:front_balancelife/modulos/modulo_habito/view/habits_view.dart';
import 'package:front_balancelife/modulos/modulo_habito/view/add_habit_view.dart';

 void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel()
          ),  
        ChangeNotifierProvider(
          create: (context) => WaterTrackerViewModel(WaterTrackerRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => StatsViewModel()
        ),
        ChangeNotifierProvider(
          create: (context) => HabitViewModel()
        ),  
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/water_tracker': (context) => const WaterTrackerView(),
        '/stats': (context) => const StatsView(), 
        '/menuEstadisticas' : (context) => const MenuEstadisticas(),
        '/habits' : (context) =>  HabitsView(),
        '/addHabit' : (context) => AddHabitView(), 
        '/minijuego1': (context) => MemoryGameView(),
        '/minijuego2': (context) => FruitGameView(),
        '/logros': (context) => LogroPage(),

      },
    );
  }
}
