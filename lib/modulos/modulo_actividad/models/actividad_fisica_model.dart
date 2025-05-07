class RegistroActividadFisica {
  final int? id;
  final int idHabito;
  final double distancia;
  final int pasos;
  final DateTime fecha;

  RegistroActividadFisica({
    this.id,
    required this.idHabito,
    required this.distancia,
    required this.pasos,
    required this.fecha,
  });

  Map<String, dynamic> toJson() => {
    "id_habito": idHabito,
    "distancia": distancia,
    "pasos": pasos,
    "fecha_registro": fecha.toIso8601String(),
  };

  factory RegistroActividadFisica.fromJson(Map<String, dynamic> json) => RegistroActividadFisica(
    id: json["id_registro"],
    idHabito: json["id_habito"],
    distancia: json["distancia"].toDouble(),
    pasos: json["pasos"],
    fecha: DateTime.parse(json["fecha_registro"]),
  );
}
