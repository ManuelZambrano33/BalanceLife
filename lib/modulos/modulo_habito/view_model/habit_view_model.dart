import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../model/habit_model.dart';
import '../repository/habit_service.dart';

class HabitViewModel extends ChangeNotifier {

  bool loading = false;
  List<HabitModel> habitListModel = [];
  HabitModel _selectedHabit;



HabitViewModel(){
  getAllHabits();
}


getHabits() async {
    setLoading(true);
    var response = await HabitService.getAllHabits();
    if (response is Success) {
      setHabitListModel(response.response as List<HabitModel>);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );
      setUserError(userError);
    }
    setLoading(false);
  }

}
