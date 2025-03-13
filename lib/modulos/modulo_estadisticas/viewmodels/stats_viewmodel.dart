import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsViewModel extends ChangeNotifier {
  List<FlSpot> actividadFisicaData = [
    FlSpot(0, 5),
    FlSpot(1, 6),
    FlSpot(2, 7),
    FlSpot(3, 8),
    FlSpot(4, 7),
    FlSpot(5, 6),
    FlSpot(6, 5),
  ];
  List<FlSpot> suenoData = [
    FlSpot(0, 7),
    FlSpot(1, 8),
    FlSpot(2, 7),
    FlSpot(3, 6),
    FlSpot(4, 7),
    FlSpot(5, 8),
    FlSpot(6, 7),
  ];
  List<FlSpot> hidratacionData = [
    FlSpot(0, 2),
    FlSpot(1, 3),
    FlSpot(2, 2.5),
    FlSpot(3, 3.5),
    FlSpot(4, 3),
    FlSpot(5, 2.5),
    FlSpot(6, 2),
  ];
  List<FlSpot> alimentacionData = [
    FlSpot(0, 2000),
    FlSpot(1, 2100),
    FlSpot(2, 2200),
    FlSpot(3, 2300),
    FlSpot(4, 2200),
    FlSpot(5, 2100),
    FlSpot(6, 2000),
  ];

  Map<String, double> alimentacionPieData = {
    "Proteínas": 30,
    "Carbohidratos": 40,
    "Grasas": 20,
    "Vitaminas": 10,
  };

  StatsViewModel() {
    notifyListeners();
  }
}