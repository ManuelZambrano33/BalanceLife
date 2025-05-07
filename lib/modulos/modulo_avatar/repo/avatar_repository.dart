import 'dart:convert';
import 'package:http/http.dart' as http;

class AvatarRepository {
  final String _baseUrl = 'http://10.153.76.115:1802/api/ModuloAvatar'; // ajusta si cambia

  List<String> getSkins() => [
        'assets/skin1.png', 'assets/skin2.png', 'assets/skin3.png'
      ];
  List<String> getHairs() => [
        'assets/hair1.png', 'assets/hair2.png', 'assets/hair3.png',
        'assets/hair4.png', 'assets/hair5.png'
      ];
  List<String> getShirts() => [
        'assets/shirt1.png', 'assets/shirt2.png', 'assets/shirt3.png',
        'assets/shirt4.png', 'assets/shirt5.png', 'assets/shirt6.png'
      ];
  List<String> getPants() => [
        'assets/pants1.png', 'assets/pants2.png', 'assets/pants3.png',
        'assets/pants4.png', 'assets/pants5.png', 'assets/pants6.png'
      ];
  List<String> getFaces() => ['assets/face1.png'];

  Future<void> crearAvatar({
    required String colorPiel,
    required String genero,
    required String colorOjos,
    required String colorCabello,
  }) async {
    final url = Uri.parse('$_baseUrl/crear');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'color_piel': colorPiel,
        'genero': genero,
        'color_ojos': colorOjos,
        'color_cabello': colorCabello,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear avatar: ${response.body}');
    }
  }

  Future<Map<String, dynamic>?> obtenerAvatar({required int idUsuario}) async {
    final url = Uri.parse('$_baseUrl/obtener/$idUsuario');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return null; // no existe avatar
    } else {
      throw Exception('Error al obtener avatar: ${response.body}');
    }
  }

  Future<void> actualizarAvatar({
    required String colorPiel,
    required String genero,
    required String colorOjos,
    required String colorCabello,
  }) async {
    final url = Uri.parse('$_baseUrl/actualizar');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'color_piel': colorPiel,
        'genero': genero,
        'color_ojos': colorOjos,
        'color_cabello': colorCabello,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar avatar: ${response.body}');
    }
  }
}
