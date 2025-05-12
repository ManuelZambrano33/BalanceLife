import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/actividad_provider.dart';
import 'package:front_balancelife/Provider/alimentacion_provider.dart';
import 'package:front_balancelife/Provider/hidratacion_provider.dart';
import 'package:front_balancelife/Provider/sueno_provider.dart';
import 'package:front_balancelife/firebase_options.dart';
import 'package:front_balancelife/modulos/modulo_actividad/views/actividad_fisica_view.dart';
import 'package:front_balancelife/modulos/modulo_alimentacion/view/food_entry_view.dart';
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
import 'package:front_balancelife/notificaciones/helper.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';
import 'package:front_balancelife/services/sharedpreference_service.dart';
import 'package:provider/provider.dart';
import 'package:front_balancelife/modulos/modulo_home/viewmodels/home_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_home/views/home_view.dart';
import 'package:front_balancelife/modulos/modulo_agua/view/water_tracker_view.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/viewmodels/stats_viewmodel.dart';
import 'package:front_balancelife/modulos/modulo_estadisticas/views/stat_view.dart';
import 'package:front_balancelife/modulos/modulo_habito/view_model/habit_view_model.dart';
import 'package:front_balancelife/modulos/modulo_habito/view/habits_view.dart';
import 'package:front_balancelife/modulos/modulo_habito/view/add_habit_view.dart';

// Importamos el ThemeViewModel y ThemeRepository
import 'package:front_balancelife/modulos/modulo_config/repo/config/theme_repository.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/config/theme_viewmodel.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Inicializar las notificaciones y obtener el token FCM
  await FirebaseService().initializeNotifications();
  
  // Obtener los datos guardados en SharedPreferences
  Map<String, dynamic> userData = await SharedPreferencesService().getUserData();

  // Cargar los datos del usuario en el UserServiceModel
  UserServiceModel.id_usuario = userData['id'];
  UserServiceModel.nombre = userData['nombre']?.isEmpty ?? true ? 'Usuario desconocido' : userData['nombre'];
  UserServiceModel.email = userData['email']?.isEmpty ?? true ? 'Email desconocido' : userData['email'];
  UserServiceModel.birthday = userData['birthday'];

  print("DESDE EL MAIN");
  print('ID: ${UserServiceModel.id_usuario}');
  print('Nombre: ${UserServiceModel.nombre}');
  print('Email: ${UserServiceModel.email}');
  print('Cumpleaños: ${UserServiceModel.birthday}');


  // Iniciar aplicación con MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => StatsViewModel()),
        ChangeNotifierProvider(create: (context) => HabitViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => AlimentacionProvider()),
        ChangeNotifierProvider(create: (_) => HidratacionProvider()),
        ChangeNotifierProvider(create: (context) => ActividadFisicaProvider()),
        ChangeNotifierProvider(create: (context) => SleepProvider()),

        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => FruitGameViewModel(UserRepository(), 1)),
        Provider<UserRepository>(create: (_) => UserRepository()),
        ChangeNotifierProvider(create: (context) => HomeConfigViewModel(SettingsRepository())),
        ChangeNotifierProvider(create: (context) => AvatarViewModel()),
        // Agregamos el ThemeViewModel como provider
        ChangeNotifierProvider(
          create: (context) => ThemeViewModel(ThemeRepository()),
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
      initialRoute: '/',  // Ruta inicial al SplashScreen o LoginView
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
