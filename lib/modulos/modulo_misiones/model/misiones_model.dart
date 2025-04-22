class Desafio {
  final int id;
  final String descripcion;
  final String estado;
  final String recompensa;

  Desafio({
    required this.id,
    required this.descripcion,
    required this.estado,
    required this.recompensa,
  });

  factory Desafio.fromJson(Map<String, dynamic> json) {
    return Desafio(
      id: json['id_desafio'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      recompensa: json['recompensa'],
    );
  }
}
