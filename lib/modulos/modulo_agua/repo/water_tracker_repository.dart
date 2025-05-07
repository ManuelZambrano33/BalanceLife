import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/water_tracker_data.dart';

class WaterTrackerRepository {
  final WaterTrackerData _data = WaterTrackerData();

  int get glasses => _data.glasses;

  void addGlass() {
    _data.increment(); // lógica original
    _sendToBackend();  // nueva conexión al backend
  }

  Future<void> _sendToBackend() async {
    const int glassSize = 250; // ml por vaso
    final url = Uri.parse('http://10.153.76.115:1802/api/ModuloHabitoHidratacion/registrar');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cantidad': glassSize}),
      );

      if (response.statusCode != 200) {
        print('❌ Error al registrar en el backend: ${response.body}');
      } else {
        print('✅ Vaso registrado en el backend');
      }
    } catch (e) {
      print('🚫 Error de conexión: $e');
    }
  }
}
