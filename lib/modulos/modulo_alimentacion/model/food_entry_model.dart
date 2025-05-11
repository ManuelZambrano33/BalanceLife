class FoodEntry {
  final int? id;
  final String tipoComida;
  final double calorias;
  final DateTime fecha;

  FoodEntry({
    this.id,
    required this.tipoComida,
    required this.calorias,
    required this.fecha,
  });

  factory FoodEntry.fromJson(Map<String, dynamic> json) {
    return FoodEntry(
      id: json['id'] as int?,
      tipoComida: json['tipo_comida'] as String,
      calorias: (json['calorias'] as num).toDouble(),
      fecha: DateTime.parse(json['fecha'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tipo_comida': tipoComida,
      'calorias': calorias,
      'fecha': fecha.toIso8601String(),
    };
  }
}
