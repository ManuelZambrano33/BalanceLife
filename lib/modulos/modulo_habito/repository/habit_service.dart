import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_balancelife/modulos/modulo_habito/model/habit_model.dart';
import 'package:front_balancelife/utils/constants.dart';
import 'package:front_balancelife/modulos/modulo_habito/repository/api_status.dart';

class HabitService {

  static Future<List<HabitModel>> getAllHabits() async {

    try {
      var url = Uri.parse(baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Succcess(response: habitListModelFromJson(response.body));
      }
    }catch (e) {
        throw Exception("Error al cargar los datos: ${response.statusCode}");
    } 
  
  }
}