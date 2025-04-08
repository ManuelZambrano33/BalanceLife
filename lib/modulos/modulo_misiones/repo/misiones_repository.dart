import 'package:modulo_misiones/model/misiones_model.dart';

class DesafioRepo {
  List<Desafio> getMisiones() {
    return [
      Desafio(id: 1, descripcion: "Iniciar sesión", estado: "pendiente", recompensa: "10 puntos"),
      Desafio(id: 2, descripcion: "Colocar una alarma", estado: "pendiente", recompensa: "10 puntos"),
      Desafio(id: 3, descripcion: "Tomar un vaso de agua", estado: "pendiente", recompensa: "10 puntos"),
    ];
  }
}
