import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modulos/modulo_home/view/home_view.dart';
import 'modulos/modulo_home/view_model/home_viewmodel.dart';
import 'modulos/modulo_agua/view/water_tracker_view.dart';
import 'modulos/modulo_agua/view_model/water_tracker_viewmodel.dart';
import 'modulos/modulo_agua/repo/water_tracker_repository.dart';

void main() {
  runApp(const BalanceLifeApp());
}

class BalanceLifeApp extends StatelessWidget {
  const BalanceLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(
            create: (_) => WaterTrackerViewModel(WaterTrackerRepository())),
      ],
      child: MaterialApp(
        title: 'Balance Life',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeView(),
          '/water_tracker': (context) => const WaterTrackerView(),
        },
      ),
    );
  }
}
