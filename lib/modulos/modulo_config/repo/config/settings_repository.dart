import 'dart:convert';
import 'package:front_balancelife/modulos/modulo_config/model/settings_model.dart';
import 'package:http/http.dart' as http;
 

class SettingsRepository {
  final String apiUrl = "https://api.tuapp.com/user";   

  Future<SettingsModel> fetchUserSettings() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
 
      return SettingsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user settings');
    }
  }

 
}
