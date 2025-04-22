import 'package:http/http.dart' as http;

class DeleteUserRepo {
  final String baseUrl = 'https://tuservidor.com/api'; 
 
  Future<bool> deleteUser(int userId) async {
    final url = Uri.parse('$baseUrl/usuarios/$userId/eliminar');  
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error al eliminar la cuenta: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Excepción al eliminar la cuenta: $e');
      return false;
    }
  }
}
