import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:front_balancelife/Provider/actividad_provider.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';

class GraficaActividadPage extends StatefulWidget {
  const GraficaActividadPage({Key? key}) : super(key: key);

  @override
  State<GraficaActividadPage> createState() => _GraficaActividadPageState();
}

class _GraficaActividadPageState extends State<GraficaActividadPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  late List<ActividadFisicaStat> filteredStats = [];

  final List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    print("🔍 Cargando datos para $selectedMonth/$selectedYear...");
    Provider.of<ActividadFisicaProvider>(context, listen: false)
        .obtenerEstadisticas(
      usuarioId: UserServiceModel.id_usuario ?? 1,
      mes: selectedMonth,
      anio: selectedYear,
    );
  }

  Widget _buildStepsChart(List<ActividadFisicaStat> stats) {
    if (stats.isEmpty) {
      return const Center(
        child: Text("No hay datos de pasos para este período"),
      );
    }

    final maxPasos = stats.map((e) => e.pasos).reduce(max).toDouble();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Registro de Pasos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minX: 1,
                  maxX: DateTime(selectedYear, selectedMonth + 1, 0).day.toDouble(),
                  minY: 0,
                  maxY: maxPasos * 1.1,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> spots) {
                        return spots.map((spot) {
                          final stat = stats.firstWhere(
                            (e) => e.fecha.day == spot.x.toInt(),
                            orElse: () => ActividadFisicaStat(
                              fecha: DateTime.now(),
                              pasos: 0,
                              kilometros: 0,
                            ),
                          );
                          return LineTooltipItem(
                            'Día ${spot.x.toInt()}\nPasos: ${stat.pasos}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final day = value.toInt();
                          if (day % 5 == 0 || day == 1 || day == meta.max.toInt()) {
                            return Text(day.toString());
                          }
                          return Text('');
                        },
                        interval: 1,
                        reservedSize: 22,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: maxPasos / 5,
                    verticalInterval: 5,
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: stats.map((e) => FlSpot(e.fecha.day.toDouble(), e.pasos.toDouble())).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.1)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistanceChart(List<ActividadFisicaStat> stats) {
    if (stats.isEmpty) {
      return const Center(
        child: Text("No hay datos de distancia para este período"),
      );
    }

    final maxKm = stats.map((e) => e.kilometros).reduce(max).toDouble();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Registro de Kilómetros",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minX: 1,
                  maxX: DateTime(selectedYear, selectedMonth + 1, 0).day.toDouble(),
                  minY: 0,
                  maxY: maxKm * 1.1,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> spots) {
                        return spots.map((spot) {
                          final stat = stats.firstWhere(
                            (e) => e.fecha.day == spot.x.toInt(),
                            orElse: () => ActividadFisicaStat(
                              fecha: DateTime.now(),
                              pasos: 0,
                              kilometros: 0,
                            ),
                          );
                          return LineTooltipItem(
                            'Día ${spot.x.toInt()}\nDistancia: ${stat.kilometros.toStringAsFixed(2)} km',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toStringAsFixed(1));
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final day = value.toInt();
                          if (day % 5 == 0 || day == 1 || day == meta.max.toInt()) {
                            return Text(day.toString());
                          }
                          return Text('');
                        },
                        interval: 1,
                        reservedSize: 22,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: maxKm / 5,
                    verticalInterval: 5,
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: stats.map((e) => FlSpot(e.fecha.day.toDouble(), e.kilometros)).toList(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.1)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actividadProvider = Provider.of<ActividadFisicaProvider>(context);
    final stats = actividadProvider.statsData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadísticas de Actividad Física"),
        backgroundColor: const Color(0xFFE07A5F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<int>(
                    value: selectedMonth,
                    items: List.generate(12, (i) => i + 1)
                        .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(monthNames[m - 1]),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedMonth = val);
                        _loadData();
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<int>(
                    value: selectedYear,
                    items: List.generate(5, (i) => DateTime.now().year - 2 + i)
                        .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedYear = val);
                        _loadData();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (actividadProvider.statsError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    actividadProvider.statsError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (actividadProvider.isFetchingStats)
                const Center(child: CircularProgressIndicator())
              else ...[
                _buildStepsChart(stats),
                const SizedBox(height: 16),
                _buildDistanceChart(stats),
              ],
            ],
          ),
        ),
      ),
    );
  }
}