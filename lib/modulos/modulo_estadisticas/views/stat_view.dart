import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewmodels/stats_viewmodel.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final statsViewModel = Provider.of<StatsViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Actividad Física", statsViewModel.actividadFisicaData),
            _buildSection("Sueño", statsViewModel.suenoData),
            _buildSection("Hidratación", statsViewModel.hidratacionData),
            _buildSection("Alimentación Saludable", statsViewModel.alimentacionData),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<FlSpot> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 200, // Aumenta la altura para que la gráfica sea más visible
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(show: true),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: data,
                  isCurved: true,
                  color: const Color.fromARGB(255, 13, 70, 117),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue.withOpacity(0.1)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}