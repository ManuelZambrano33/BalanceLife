import 'package:flutter/material.dart';
import '../model/habit_model.dart';
import '../repository/habit_service.dart';

class HabitViewModel extends ChangeNotifier {
  final HabitService _habitService = HabitService();
  List<HabitModel> _habits = [];
  bool _isLoading = false;

  List<HabitModel> get habits => _habits;
  bool get isLoading => _isLoading;

  HabitViewModel() {
    fetchHabits();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchHabits() async {
    setLoading(true);
    try {
      _habits = await _habitService.getAllHabits();
    } catch (e) {
      print("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> toggleHabit(String habitId) async {
    int index = _habits.indexWhere((h) => h.id == habitId);
    if (index != -1) {
      _habits[index].done = !_habits[index].done;
      notifyListeners();
      await _habitService.toggleHabitCompletion(habitId, _habits[index].done);
    }
  }

  Future<void> addHabit(HabitModel habit) async {
  _habits.add(habit);
  notifyListeners();
  await _habitService.createHabit(habit);
}


  
}
