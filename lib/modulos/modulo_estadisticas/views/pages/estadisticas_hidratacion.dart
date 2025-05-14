import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:front_balancelife/Provider/hidratacion_provider.dart';
import 'package:front_balancelife/services/UserServiceModel.dart';

class EstadisticasHidratacion extends StatefulWidget {
  const EstadisticasHidratacion({super.key});

  @override
  State<EstadisticasHidratacion> createState() => _EstadisticasHidratacionState();
}

class _EstadisticasHidratacionState extends State<EstadisticasHidratacion> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedWeek = 1;
  List<HidratacionStat> _estadisticas = [];
  bool _cargando = true;
  String? _error;
  int? _selectedDay;
  HidratacionStat? _selectedStat;

  final List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now().day;
    _cargarEstadisticas();
  }

  Future<void> _cargarEstadisticas() async {
    setState(() {
      _cargando = true;
      _error = null;
    });

    try {
      final stats = await HidratacionProvider.obtenerEstadisticas(
        usuarioId: UserServiceModel.id_usuario!,
        mes: selectedMonth,
        anio: selectedYear,
      );

      setState(() {
        _estadisticas = _filtrarSemana(stats);
        _selectedStat = _estadisticas.firstWhere(
          (e) => e.fecha.day == _selectedDay,
          orElse: () => HidratacionStat(
            fecha: DateTime(selectedYear, selectedMonth, _selectedDay!),
            cantidad: 0,
          ),
        );
      });
    } catch (e) {
      setState(() => _error = "Error al cargar los datos");
    } finally {
      setState(() => _cargando = false);
    }
  }

  List<HidratacionStat> _filtrarSemana(List<HidratacionStat> estadisticas) {
    final daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    final int startDay = (selectedWeek - 1) * 7 + 1;
    int endDay = selectedWeek * 7;
    endDay = endDay > daysInMonth ? daysInMonth : endDay;

    List<HidratacionStat> semana = [];
    for (int dia = startDay; dia <= endDay; dia++) {
      final stat = estadisticas.firstWhere(
        (e) => e.fecha.day == dia,
        orElse: () => HidratacionStat(fecha: DateTime(selectedYear, selectedMonth, dia), cantidad: 0),
      );
      semana.add(stat);
    }
    return semana;
  }

  Widget _buildLineChart() {
  if (_estadisticas.isEmpty) return const SizedBox.shrink();

  final maxY = _estadisticas.map((e) => e.cantidad).reduce((a, b) => a > b ? a : b).toDouble();
  final adjustedMaxY = maxY > 0 ? maxY * 1.2 : 2000;

  return Column(
    children: [
       // Título encima de la gráfica
      const Text(
        'Vasos de agua diarios',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center, // Asegura que el título esté centrado
      ),
      const SizedBox(height: 5), // Espacio entre el título y la gráfica
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3, // 40% de la altura de la pantalla
        child: LineChart(
          LineChartData(
            minX: _estadisticas.first.fecha.day.toDouble(),
            maxX: _estadisticas.last.fecha.day.toDouble(),
            minY: 0,
            maxY: adjustedMaxY.toDouble(),
            lineTouchData: LineTouchData(
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                if (event is FlTapUpEvent && response != null) {
                  final spot = response.lineBarSpots?.first;
                  if (spot != null) {
                    setState(() {
                      _selectedDay = spot.x.toInt();
                      _selectedStat = _estadisticas.firstWhere(
                        (e) => e.fecha.day == _selectedDay,
                        orElse: () => HidratacionStat(
                          fecha: DateTime(selectedYear, selectedMonth, _selectedDay!),
                          cantidad: 0,
                        ),
                      );
                    });
                  }
                }
              },
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (spots) => spots.map((spot) {
                  return LineTooltipItem(
                    'Día ${spot.x.toInt()}\n${spot.y.toInt()} ml',
                    const TextStyle(color: Colors.white),
                  );
                }).toList(),
              ),
            ),
            titlesData: FlTitlesData(
      
              // Eje superior (opcional)
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Desactiva los números en el eje superior
              ),
              // Eje derecho (opcional)
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Desactiva los números en el eje derecho
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: _estadisticas.map((e) => FlSpot(e.fecha.day.toDouble(), e.cantidad.toDouble())).toList(),
                isCurved: false,
                color: const Color.fromARGB(255, 12, 59, 97),
                barWidth: 3,
                belowBarData: BarAreaData(show: true, color:Color.fromARGB(139, 46, 128, 195).withOpacity(0.5) ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}


  SideTitles get _leftTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
    reservedSize: 40,
  );

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(value.toInt().toString()),
    ),
  );

  Widget _buildPieChart() {
    final metaDiaria = int.tryParse(UserServiceModel.meta_hidratacion ?? '2000') ?? 2000;
    final consumido = _selectedStat?.cantidad ?? 0;
    final progress = metaDiaria > 0 ? consumido / metaDiaria : 0;

    return Column(
      children: [
        const Text(
        'Progreso diario relativo a la meta',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, 
        ),
        SizedBox(
          height:  MediaQuery.of(context).size.height * 0.25, // 20% de la altura de la pantalla
          child: Stack(
            alignment: Alignment.center,
            children: [
              
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 50,
                  sections: [
                    PieChartSectionData(
                      color:  Color.fromARGB(197, 33, 130, 210),
                      value: progress.clamp(0, 1) * 100,
                      title: '${(progress * 100).toStringAsFixed(1)}%',
                      radius: 25,
                      titleStyle: const TextStyle(
                        color: Color.fromARGB(255, 21, 19, 19),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
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
                    '${consumido}ml',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'de $metaDiaria ml',
                    style: TextStyle(
                      fontSize: 14,
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

  Widget _buildDateBox() {
    final fecha = _selectedStat?.fecha ?? DateTime.now();
    final consumido = _selectedStat?.cantidad ?? 0;
    final vasos = consumido; // Asumiendo 250ml por vaso

    return Container(
    padding: const EdgeInsets.all(16),
    width: MediaQuery.of(context).size.width * 0.3,  // Ancho fijo para el contenedor
    decoration: BoxDecoration(
      color: const Color.fromARGB(54, 112, 185, 245),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color.fromARGB(255, 12, 59, 97),
        width: 1.5,
      ),
    ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Text(
            DateFormat('dd MMM yyyy').format(fecha),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Vasos consumidos',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            vasos.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:  Color.fromARGB(255, 12, 59, 97),
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildFaltanteBox() {
    final fecha = _selectedStat?.fecha ?? DateTime.now();
    final consumido = _selectedStat?.cantidad ?? 0;
    final vasos = consumido; 
    final metaVasos = int.tryParse(UserServiceModel.meta_hidratacion ?? '0') ?? 0; 
    int faltante = metaVasos - vasos;
    if (faltante < 0) {
      faltante = 0; // Asegúrate de que no sea negativo
    }
    return Container(
    padding: const EdgeInsets.all(16),
    width: MediaQuery.of(context).size.width * 0.3,  // Ancho fijo para el contenedor
    decoration: BoxDecoration(
      color: const Color.fromARGB(65, 112, 185, 245),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color.fromARGB(255, 12, 59, 97),
        width: 1.5,
      ),
    ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          
          Text(
            'Vasos faltantes',
            style: TextStyle(
              fontSize: 17,   
              fontWeight: FontWeight.bold,           
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            faltante.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:  Color.fromARGB(255, 12, 59, 97),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas de Hidratación")),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMonthSelector(),
                      _buildYearSelector(),
                      _buildWeekSelector(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildLineChart(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildPieChart(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                     Column(
                      children: [
                        _buildDateBox(),
                          const SizedBox(height: 5),
                          _buildFaltanteBox(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildMonthSelector() => DropdownButton<int>(
    value: selectedMonth,
    items: monthNames.asMap().entries.map((e) => DropdownMenuItem(
      value: e.key + 1,
      child: Text(e.value),
    )).toList(),
    onChanged: (v) => setState(() {
      selectedMonth = v!;
      _cargarEstadisticas();
    }),
  );

  Widget _buildYearSelector() => DropdownButton<int>(
    value: selectedYear,
    items: List.generate(5, (i) => DateTime.now().year - 2 + i)
        .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
        .toList(),
    onChanged: (v) => setState(() {
      selectedYear = v!;
      _cargarEstadisticas();
    }),
  );

  Widget _buildWeekSelector() => DropdownButton<int>(
    value: selectedWeek,
    items: List.generate(5, (i) => i + 1)
        .map((w) => DropdownMenuItem(value: w, child: Text('Semana $w')))
        .toList(),
    onChanged: (v) => setState(() {
      selectedWeek = v!;
      _cargarEstadisticas();
    }),
  );
}