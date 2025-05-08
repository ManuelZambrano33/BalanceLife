import 'package:flutter/material.dart';
import 'package:front_balancelife/firebase_options.dart';
import 'package:front_balancelife/modulos/modulo_actividad/repo/actividad_fisica_repository.dart';
import 'package:front_balancelife/modulos/modulo_actividad/viewmodels/actividad_fisica_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_actividad/views/actividad_fisica_view.dart';
import 'package:front_balancelife/modulos/modulo_alimentacion/view/food_entry_view.dart';
import 'package:front_balancelife/modulos/modulo_alimentacion/viewmodel/food_entry_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_auth/view/login_view.dart';
import 'package:front_balancelife/modulos/modulo_auth/view/register_view.dart';
import 'package:front_balancelife/modulos/modulo_auth/viewmodels/login_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_auth/viewmodels/register_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_avatar/view/avatar_view.dart';
import 'package:front_balancelife/modulos/modulo_avatar/view_model/avatar_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_config/repo/config/settings_repository.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/viewmodel_home.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/menu_estadisticas.dart';
import 'package:front_balancelife/modulos/modulo_logros/view/logro_page.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/repo/user_repository.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/view/fruit_game_view.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/view/home_view.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/view/memory_game_view.dart';
import 'package:front_balancelife/modulos/modulo_minijuegos/viewmodel/fruit_game_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_sleep/view/sleep_page.dart';
import 'package:front_balancelife/modulos/modulo_sleep/viewmodel/sleep_viewmodel.dart';
import 'package:front_balancelife/notificaciones/UnifiedNotificationService.dart';
import 'package:front_balancelife/notificaciones/helper.dart';
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

import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar las notificaciones
  await UnifiedNotificationService.initialize();

  // Programar notificaciones específicas
  await UnifiedNotificationService.scheduleDailyNotification(
    id: 1,
    title: '¡Hora de beber agua!',
    body: 'Recuerda mantenerte hidratado a lo largo del día.',
    hour: 8,
    minute: 0,
  );

  await UnifiedNotificationService.scheduleDailyNotification(
    id: 2,
    title: '¡Hora de salir a caminar!',
    body: 'Que tal un paseo a esta hora.',
    hour: 15,
    minute: 0,
  );

  await UnifiedNotificationService.scheduleDailyNotification(
    id: 3,
    title: '¡Hora de desayunar!',
    body: 'El desayuno es la comida más importante del día.',
    hour: 7,
    minute: 0,
  );

  await UnifiedNotificationService.scheduleDailyNotification(
    id: 4,
    title: '¡Hora de almorzar!',
    body: 'Registra tu almuerzo.',
    hour: 12,
    minute: 0,
  );

  await UnifiedNotificationService.scheduleDailyNotification(
    id: 5,
    title: '¡Hora de cenar',
    body: 'Registra la ultima comida del día',
    hour: 20,
    minute: 0,
  );

  await UnifiedNotificationService.scheduleNapNotification(
    DateTime.now().add(const Duration(hours: 1)), 
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => WaterTrackerViewModel(WaterTrackerRepository())),
        ChangeNotifierProvider(create: (context) => StatsViewModel()),
        ChangeNotifierProvider(create: (context) => HabitViewModel()),
        ChangeNotifierProvider(create: (context) => SleepViewModel()),
        ChangeNotifierProvider(create: (context) => ActividadFisicaViewModel(ActividadFisicaRepository())),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => FoodEntryViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => FruitGameViewModel(UserRepository(), 1)),
        Provider<UserRepository>(create: (_) => UserRepository()),
        ChangeNotifierProvider(create: (context) => HomeConfigViewModel(SettingsRepository())),
        ChangeNotifierProvider(create: (context) => AvatarViewModel()),
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
        '/': (context) => LoginView(),
        '/homeView': (context) => const HomeView(),
        '/register': (context) => RegisterView(),
        '/water_tracker': (context) => const WaterTrackerView(),
        '/stats': (context) => const StatsView(),
        '/menuEstadisticas': (context) => const MenuEstadisticas(),
        '/habits': (context) => HabitsView(),
        '/addHabit': (context) => AddHabitView(),
        '/minijuego1': (context) => MemoryGameView(),
        '/minijuego2': (context) => FruitGameView(),
        '/logros': (context) => LogroPage(),
        '/sleep_page': (context) => SleepPage(),
        '/home_juegos': (context) => HomeMiniJuegosView(),
        '/exercise': (context) => const ActividadFisicaView(),
        '/healthy_food': (context) => const FoodEntryView(),
        '/avatar': (context) => AvatarView(),
      },
    );
  }
}