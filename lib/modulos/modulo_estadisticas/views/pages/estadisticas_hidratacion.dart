import 'package:flutter/material.dart';
import 'package:front_balancelife/Provider/hidratacion_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';

class EstadisticasHidratacion extends StatefulWidget {
  const EstadisticasHidratacion({super.key});

  @override
  State<EstadisticasHidratacion> createState() => _EstadisticasHidratacionState();
}

class _EstadisticasHidratacionState extends State<EstadisticasHidratacion> {
  List<HidratacionStat> _estadisticas = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarEstadisticas();
  }

  Future<void> _cargarEstadisticas() async {
    setState(() => _cargando = true);

    try {
      final stats = await HidratacionProvider.obtenerEstadisticas(
        usuarioId: UserServiceModel.id_usuario!,
        date: DateTime.now(),
      );

      setState(() => _estadisticas = stats);
    } catch (e) {
      print("Error al cargar estadísticas: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar estadísticas")),
      );
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas de Hidratación")),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _estadisticas.isEmpty
              ? const Center(child: Text("No hay datos disponibles"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        "Ml tomados en el mes",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _generarLineChartData(),
                                    isCurved: true,
                                    color: Colors.blueAccent,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: FlDotData(show: false),
                                  ),
                                ],
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true, interval: 500),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, _) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  // Generar puntos de la gráfica
  List<FlSpot> _generarLineChartData() {
    return _estadisticas.map((stat) {
      // Generamos un FlSpot (día, cantidad de agua tomada)
      return FlSpot(stat.fecha.day.toDouble(), stat.cantidad.toDouble());
    }).toList();
  }
}
