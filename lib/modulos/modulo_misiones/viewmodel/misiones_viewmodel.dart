import 'package:flutter/material.dart';
import 'package:modulo_misiones/model/misiones_model.dart';
import 'package:modulo_misiones/repo/misiones_repository.dart';


class DesafioViewModel extends ChangeNotifier {
  final _repo = DesafioRepo();
  List<Desafio> _misiones = [];
  int puntos = 0;

  List<Desafio> get misiones => _misiones;

  DesafioViewModel() {
    cargarMisiones();
  }

  void cargarMisiones() {
    _misiones = _repo.getMisiones();
    notifyListeners();
  }

  void completarMision(int id) {
    final index = _misiones.indexWhere((m) => m.id == id);
    if (_misiones[index].estado != "completado") {
      _misiones[index] = Desafio(
        id: _misiones[index].id,
        descripcion: _misiones[index].descripcion,
        estado: "completado",
        recompensa: _misiones[index].recompensa,
      );
      notifyListeners();

      // Agregar puntos si ya completó las 3
      if (_misiones.every((m) => m.estado == "completado")) {
        puntos += 30;
        notifyListeners();
      }
    }
  }
}
