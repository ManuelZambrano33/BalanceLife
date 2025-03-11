import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_agua/repo/water_tracker_repository.dart';
import 'package:provider/provider.dart';
import 'package:front_balancelife/modulos/modulo_agua/view/water_tracker_view.dart';
import 'package:front_balancelife/modulos/modulo_agua/modelview/water_tracker_viewmodel.dart';

void main() {
  final repository = WaterTrackerRepository(); 

  runApp(
    ChangeNotifierProvider(
      create: (context) => WaterTrackerViewModel(repository), 
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
      home: const WaterTrackerView(),
    );
  }
}
