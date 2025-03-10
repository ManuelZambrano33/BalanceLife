import 'package:flutter/material.dart';
import 'package:front_balancelife/repo/water_tracker_repository.dart';
import 'package:provider/provider.dart';
import 'view/water_tracker_view.dart';
import 'modelview/water_tracker_viewmodel.dart';

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
