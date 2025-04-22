import 'package:flutter/material.dart';
import '../model/logro.dart';
import '../repo/logro_repo.dart';

class LogroViewModel extends ChangeNotifier {
  final LogroRepo _repo = LogroRepo();
  List<Logro> _logros = [];

  List<Logro> get logros => _logros;

  Future<void> cargarLogros() async {
    _logros = await _repo.fetchLogros();
    notifyListeners();
  }

  void desbloquearLogro(int id) {
    final index = _logros.indexWhere((l) => l.id == id);
    if (index != -1 && !_logros[index].estado) {
      _logros[index] = Logro(
        id: _logros[index].id,
        descripcion: _logros[index].descripcion,
        fechaDesbloqueo: DateTime.now().toIso8601String(),
        puntosGanados: _logros[index].puntosGanados,
        idUsuario: _logros[index].idUsuario,
        estado: true,
      );
      notifyListeners();
    }
  }
}
