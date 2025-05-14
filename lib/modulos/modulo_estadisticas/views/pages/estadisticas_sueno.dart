import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:front_balancelife/Provider/sueno_provider.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';

class EstadisticasSuenoPage extends StatefulWidget {
  const EstadisticasSuenoPage({Key? key}) : super(key: key);

  @override
  State<EstadisticasSuenoPage> createState() => _EstadisticasSuenoPageState();
}

class _EstadisticasSuenoPageState extends State<EstadisticasSuenoPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedWeek = 1;
  SleepStat? selectedDayStat;
  double metaDiariaSueno = 8.0; // Valor por defecto (8 horas)

  final List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  @override
  void initState() {
    super.initState();
    print('🔄 initState llamado');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('📌 Post-frame callback ejecutándose');
      _loadUserMeta();
      _loadData();
    });
  }

  Future<void> _loadUserMeta() async {
    print('🔍 Iniciando _loadUserMeta()');
    try {
      print('📊 UserServiceModel.meta_sueno ANTES: ${UserServiceModel.meta_sueno}');
      final meta = UserServiceModel.meta_sueno ?? '8.0';
      print('📊 UserServiceModel.meta_sueno DESPUÉS: $meta');
      
      final parsedMeta = double.tryParse(meta);
      print('🔢 Valor parseado: $parsedMeta');
      
      setState(() {
        metaDiariaSueno = parsedMeta ?? 8.0;
        print('✅ Meta diaria establecida: $metaDiariaSueno');
      });
    } catch (e) {
      print('❌ Error en _loadUserMeta: $e');
      print('🔄 Estableciendo valor por defecto (8.0)');
      setState(() {
        metaDiariaSueno = 8.0;
      });
    }
  }

  void _loadData() {
    print('\n📡 Iniciando _loadData()');
    try {
      final usuarioId = UserServiceModel.id_usuario;
      print('👤 ID Usuario: $usuarioId');
      
      if (usuarioId == null) {
        print('⚠️ ATENCIÓN: UserServiceModel.id_usuario es NULL');
      }
      
      print("🔍 Obteniendo estadísticas para $selectedMonth/$selectedYear...");
      
      Provider.of<SleepProvider>(context, listen: false)
          .obtenerEstadisticas(
            usuarioId: usuarioId ?? 1, // Valor por defecto 1 si es null
            mes: selectedMonth,
            anio: selectedYear,
          )
          .then((_) {
            print('📊 Datos obtenidos con éxito');
            if (mounted) {
              final stats = Provider.of<SleepProvider>(context, listen: false).stats;
              print('📈 Cantidad de registros obtenidos: ${stats.length}');
              setState(() {
                selectedDayStat = null;
              });
            }
          })
          .catchError((error) {
            print('❌ Error al obtener estadísticas: $error');
          });
    } catch (e) {
      print('‼️ Error crítico en _loadData: $e');
    }
  }

  List<SleepStat> _getWeekData(List<SleepStat> allStats) {
    final firstDayOfMonth = DateTime(selectedYear, selectedMonth, 1);
    final lastDayOfMonth = DateTime(selectedYear, selectedMonth + 1, 0);
    
    final weekStart = firstDayOfMonth.add(Duration(days: (selectedWeek - 1) * 7));
    
    List<SleepStat> weekStats = [];
    for (int i = 0; i < 7; i++) {
      final currentDay = weekStart.add(Duration(days: i));
      if (currentDay.isAfter(lastDayOfMonth)) break;
      
      final existingStat = allStats.firstWhere(
        (stat) => stat.fecha.day == currentDay.day && 
                  stat.fecha.month == currentDay.month,
        orElse: () => SleepStat(
          fecha: currentDay,
          duracion: 0.0,
        ),
      );
      
      weekStats.add(existingStat);
    }
    
    return weekStats;
  }

  Widget _buildWeekSelector(int totalWeeks) {
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

  Widget _buildSleepChart(List<SleepStat> allStats) {
    final weekStats = _getWeekData(allStats);
    
    // Asegurar que maxY nunca sea cero
    final maxY = max(metaDiariaSueno * 1.5, 10.0);
    final horizontalInterval = max((maxY / 5), 2.0);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Horas de Sueño Diarias",
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
                  maxY: maxY,
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
                          final progress = stat.duracion > 0 ? (stat.duracion / metaDiariaSueno * 100).toStringAsFixed(0) : "0";
                          return LineTooltipItem(
                            'Día ${stat.fecha.day}\n'
                            'Horas: ${stat.duracion.toStringAsFixed(1)}\n'
                            'Meta: ${metaDiariaSueno.toStringAsFixed(1)}h (${progress}%)',
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
                        return FlSpot((index + 1).toDouble(), weekStats[index].duracion);
                      }),
                      isCurved: true,
                      color: const Color(0xFF5F84E0), // Azul para sueño
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: const Color(0xFF5F84E0),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true, 
                        color: const Color(0xFF5F84E0).withOpacity(0.1),
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

    final consumido = selectedDayStat!.duracion;
    final progress = metaDiariaSueno > 0 ? consumido / metaDiariaSueno : 0;

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
                      color: const Color(0xFF5F84E0),
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
                    '${consumido.toStringAsFixed(1)}h',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'de ${metaDiariaSueno.toStringAsFixed(1)}h',
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

    final progress = (selectedDayStat!.duracion / metaDiariaSueno * 100).toStringAsFixed(0);
    final remaining = (metaDiariaSueno - selectedDayStat!.duracion).clamp(0, metaDiariaSueno);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Día ${selectedDayStat!.fecha.day}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5F84E0),
          ),
        ),
        const SizedBox(height: 8),
        _buildInfoItem("Fecha", DateFormat('dd MMM yyyy').format(selectedDayStat!.fecha)),
        const SizedBox(height: 8),
        _buildInfoItem("Horas de sueño", "${selectedDayStat!.duracion.toStringAsFixed(1)}"),
        const SizedBox(height: 8),
        _buildInfoItem("Progreso", "$progress%"),
        const SizedBox(height: 8),
        _buildInfoItem(
          selectedDayStat!.duracion >= metaDiariaSueno ? "Superada por" : "Faltan",
          selectedDayStat!.duracion >= metaDiariaSueno 
              ? "${(selectedDayStat!.duracion - metaDiariaSueno).toStringAsFixed(1)}h" 
              : "${remaining.toStringAsFixed(1)}h"
        ),
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
    final suenoProvider = Provider.of<SleepProvider>(context);
    final stats = suenoProvider.stats;
    final firstDayOfMonth = DateTime(selectedYear, selectedMonth, 1);
    final lastDayOfMonth = DateTime(selectedYear, selectedMonth + 1, 0);
    final totalWeeks = ((lastDayOfMonth.difference(firstDayOfMonth).inDays + firstDayOfMonth.weekday) / 7).ceil();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadísticas de Sueño"),
        backgroundColor: const Color(0xFF5F84E0), // Azul para sueño
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWeekSelector(totalWeeks),
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
              
              if (suenoProvider.fetchError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    suenoProvider.fetchError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              
              if (suenoProvider.isFetching)
                const Center(child: CircularProgressIndicator())
              else if (stats.isNotEmpty) ...[
                _buildSleepChart(stats),
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