class Logro {
  final int id;
  final String descripcion;
  final String? fechaDesbloqueo;
  final int puntosGanados;
  final int? idUsuario;
  final bool estado;

  Logro({
    required this.id,
    required this.descripcion,
    this.fechaDesbloqueo,
    required this.puntosGanados,
    this.idUsuario,
    required this.estado,
  });

  factory Logro.fromJson(Map<String, dynamic> json) => Logro(
        id: json['id_logro'],
        descripcion: json['descripcion'],
        fechaDesbloqueo: json['fecha_desbloqueo'],
        puntosGanados: json['puntos_ganados'],
        idUsuario: json['id_usuario'],
        estado: json['estado'],
      );
}
