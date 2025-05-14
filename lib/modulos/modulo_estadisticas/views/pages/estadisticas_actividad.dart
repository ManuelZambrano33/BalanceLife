import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
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
  int selectedWeek = 1;
  ActividadFisicaStat? selectedDayStat;
  int metaDiariaPasos = 10000; 

  final List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserMeta();
      _loadData();
    });
  }

  Future<void> _loadUserMeta() async {
    try {
      final meta = UserServiceModel.meta_deporte;
      setState(() {
        metaDiariaPasos = meta != null && meta.isNotEmpty ? int.parse(meta) : 10000;
      });
    } catch (e) {
      print("Error al cargar meta deportiva: $e");
      setState(() {
        metaDiariaPasos = 10000;
      });
    }
  }

  void _loadData() {
    print("🔍 Cargando datos para $selectedMonth/$selectedYear...");
    Provider.of<ActividadFisicaProvider>(context, listen: false)
        .obtenerEstadisticas(
      usuarioId: UserServiceModel.id_usuario ?? 1,
      mes: selectedMonth,
      anio: selectedYear,
    ).then((_) {
      if (mounted) {
        final stats = Provider.of<ActividadFisicaProvider>(context, listen: false).statsData;
        setState(() {
          // No seleccionamos ningún día por defecto al cargar
          selectedDayStat = null;
        });
      }
    });
  }

  List<ActividadFisicaStat> _getWeekData(List<ActividadFisicaStat> allStats) {
    final firstDayOfMonth = DateTime(selectedYear, selectedMonth, 1);
    
    // Asumimos meses de exactamente 30 días
    final lastDayOfMonth = DateTime(selectedYear, selectedMonth, 30);
    
    final weekStart = firstDayOfMonth.add(Duration(days: (selectedWeek - 1) * 7));
    
    List<ActividadFisicaStat> weekStats = [];
    for (int i = 0; i < 7; i++) {
      final currentDay = weekStart.add(Duration(days: i));
      if (currentDay.isAfter(lastDayOfMonth)) break;
      
      final existingStat = allStats.firstWhere(
        (stat) => stat.fecha.day == currentDay.day && 
                  stat.fecha.month == currentDay.month,
        orElse: () => ActividadFisicaStat(
          fecha: currentDay,
          pasos: 0,
          kilometros: 0.0,
        ),
      );
      
      weekStats.add(existingStat);
    }
    
    return weekStats;
  }

  Widget _buildWeekSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<int>(
        value: selectedWeek,
        underline: Container(),
        items: List.generate(4, (i) => i + 1) // Semanas del 1 al 4
            .map((week) => DropdownMenuItem(
                  value: week,
                  child: Text(
                    'Semana $week',
                    style: const TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        onChanged: (val) {
          if (val != null && mounted) {
            setState(() {
              selectedWeek = val;
              selectedDayStat = null;
            });
            _loadData();
          }
        },
      ),
    );
  }

  Widget _buildStepsChart(List<ActividadFisicaStat> allStats) {
    final weekStats = _getWeekData(allStats);
    
    // Asegurar que maxPasos nunca sea cero
    final maxPasos = max(metaDiariaPasos * 1.5, 1000).toDouble();
    final horizontalInterval = max((maxPasos / 5), 1000).toDouble();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Pasos Diarios",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  minX: 1,
                  maxX: 7,
                  minY: 0,
                  maxY: maxPasos,
                  lineTouchData: LineTouchData(
                    touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                      if (response?.lineBarSpots != null && event is FlTapUpEvent) {
                        final spotIndex = response?.lineBarSpots?.first.spotIndex;
                        if (spotIndex != null && spotIndex < weekStats.length && mounted) {
                          setState(() {
                            selectedDayStat = weekStats[spotIndex];
                          });
                        }
                      }
                    },
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> spots) {
                        return spots.map((spot) {
                          final stat = weekStats[spot.spotIndex];
                          final progress = stat.pasos > 0 ? (stat.pasos / metaDiariaPasos * 100).toStringAsFixed(0) : "0";
                          return LineTooltipItem(
                            'Día ${stat.fecha.day}\n'
                            'Pasos: ${stat.pasos}\n'
                            'Meta: $metaDiariaPasos pasos (${progress}%)',
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
                          final dayIndex = value.toInt() - 1;
                          if (dayIndex >= 0 && dayIndex < weekStats.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${weekStats[dayIndex].fecha.day}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }
                          return const Text('');
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
                    horizontalInterval: horizontalInterval,
                    verticalInterval: 1,
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(weekStats.length, (index) {
                        return FlSpot((index + 1).toDouble(), weekStats[index].pasos.toDouble());
                      }),
                      isCurved: true,
                      color: const Color(0xFFE07A5F),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: const Color(0xFFE07A5F),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true, 
                        color: const Color(0xFFE07A5F).withOpacity(0.1),
                      ),
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

  Widget _buildPieChart() {
    if (selectedDayStat == null) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: const Text(
          "Selecciona un día en la gráfica para ver detalles",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final consumido = selectedDayStat!.pasos;
    final progress = metaDiariaPasos > 0 ? consumido / metaDiariaPasos : 0;

    return Column(
      children: [
        const Text(
          'Progreso Diario',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 50,
                  sections: [
                    PieChartSectionData(
                      color: Color(0xFFF8E9D2),
                      value: progress.clamp(0, 1) * 100,
                      title: '${(progress * 100).toStringAsFixed(1)}%',
                      radius: 25,
                      titleStyle: const TextStyle(
                        color: Color.fromARGB(255, 21, 19, 19),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.grey[300]!,
                      value: (1 - progress.clamp(0, 1)) * 100,
                      title: '',
                      radius: 25,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${consumido} pasos',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'de $metaDiariaPasos',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayInfoBox() {
    if (selectedDayStat == null) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: const Text(
          "",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final progress = (selectedDayStat!.pasos / metaDiariaPasos * 100).toStringAsFixed(0);
    final remaining = (metaDiariaPasos - selectedDayStat!.pasos).clamp(0, metaDiariaPasos);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Día ${selectedDayStat!.fecha.day}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE07A5F),
          ),
        ),
        const SizedBox(height: 8),
        _buildInfoItem("Fecha", DateFormat('dd MMM yyyy').format(selectedDayStat!.fecha)),
        const SizedBox(height: 8),
        _buildInfoItem("Pasos", "${selectedDayStat!.pasos}"),
        const SizedBox(height: 8),
        _buildInfoItem("Progreso", "$progress%"),
        const SizedBox(height: 8),
        _buildInfoItem(
          selectedDayStat!.pasos >= metaDiariaPasos ? "Superada por" : "Faltan",
          selectedDayStat!.pasos >= metaDiariaPasos 
              ? "${selectedDayStat!.pasos - metaDiariaPasos} pasos" 
              : "$remaining pasos"
        ),
        const SizedBox(height: 8),
        _buildInfoItem("Kilómetros", selectedDayStat!.kilometros.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
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
              // Fila con los tres selectores
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Selector de semanas (1-4)
                  _buildWeekSelector(),

                  // Selector de mes
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<int>(
                      value: selectedMonth,
                      underline: Container(),
                      items: List.generate(12, (i) => i + 1)
                          .map((m) => DropdownMenuItem(
                                value: m,
                                child: Text(
                                  monthNames[m - 1],
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null && mounted) {
                          setState(() {
                            selectedMonth = val;
                            selectedWeek = 1;
                            selectedDayStat = null;
                            _loadData();
                          });
                        }
                      },
                    ),
                  ),

                  // Selector de año
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<int>(
                      value: selectedYear,
                      underline: Container(),
                      items: List.generate(5, (i) => DateTime.now().year - 2 + i)
                          .map((y) => DropdownMenuItem(
                                value: y,
                                child: Text(
                                  '$y',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null && mounted) {
                          setState(() {
                            selectedYear = val;
                            selectedWeek = 1;
                            selectedDayStat = null;
                            _loadData();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              
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
              else if (stats.isNotEmpty) ...[
                _buildStepsChart(stats),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Detalles del Día',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 600) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _buildPieChart(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: _buildDayInfoBox(),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  _buildPieChart(),
                                  const SizedBox(height: 16),
                                  _buildDayInfoBox(),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Center(
                  child: Text("No hay datos disponibles para este período"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}