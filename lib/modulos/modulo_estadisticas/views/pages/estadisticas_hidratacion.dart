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
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: _getMaxY(_estadisticas),
                            barTouchData: BarTouchData(enabled: true),
                            gridData: FlGridData(show: false), // 👈 Quitar el grid
                            borderData: FlBorderData(show: false), // 👈 Quitar el borde
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
                            barGroups: _generarBarGroupsDelMes(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  double _getMaxY(List<HidratacionStat> datos) {
    final max = datos.map((e) => e.cantidad).fold(0, (prev, next) => next > prev ? next : prev);
    return max < 100 ? 100 : (max + 500).toDouble(); // Ajuste visual
  }

  List<BarChartGroupData> _generarBarGroupsDelMes() {
  final now = DateTime.now();
  final totalDias = DateUtils.getDaysInMonth(now.year, now.month);

  // Mapa rápido para buscar cantidades por día
  final mapaDatos = {for (var stat in _estadisticas) stat.fecha.day: stat.cantidad};

  return List.generate(totalDias, (index) {
    final dia = index + 1;
    final cantidad = mapaDatos[dia] ?? 0;

    return BarChartGroupData(
      x: dia,
      barRods: [
        BarChartRodData(
          toY: cantidad.toDouble(),
          color: Colors.blueAccent,
        )
      ],
    );
  });
}

}
