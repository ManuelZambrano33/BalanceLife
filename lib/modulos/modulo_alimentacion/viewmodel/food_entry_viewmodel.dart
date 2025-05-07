import 'package:flutter/material.dart';
import '../model/food_entry_model.dart' as model;
import '../repo/food_entry_repo.dart';

class FoodEntryViewModel with ChangeNotifier {
  final FoodEntryRepo _repo = FoodEntryRepo();

  String? tipo;
  String? cantidadText;
  String? caloriasText;

  bool isLoading = false;
  String? error;
  bool success = false;

  List<String> tipos = ['Desayuno', 'Almuerzo', 'Cena'];

  void setTipo(String? newTipo) {
    tipo = newTipo;
    notifyListeners();
  }

  void setCantidad(String text) {
    cantidadText = text;
    notifyListeners();
  }

  void setCalorias(String text) {
    caloriasText = text;
    notifyListeners();
  }

  Future<void> registerEntry() async {
    if (tipo == null || cantidadText == null || caloriasText == null || 
        tipo!.isEmpty || cantidadText!.isEmpty || caloriasText!.isEmpty) {
      error = 'Por favor completa todos los campos';
      notifyListeners();
      return;
    }

    final cantidad = double.tryParse(cantidadText!);
    final calorias = double.tryParse(caloriasText!);

    if (cantidad == null || calorias == null) {
      error = 'Cantidad y calorías deben ser números válidos';
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    success = false;
    notifyListeners();

    final entry = model.FoodEntry(
      tipoComida: tipo!,         // Asegúrate de que sea "tipoComida"
      cantidad: cantidad,
      calorias: calorias,
      fecha: DateTime.now(),
    );

    try {
      await _repo.saveEntry(entry);
      success = true;
    } catch (e) {
      error = 'Error al registrar: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
