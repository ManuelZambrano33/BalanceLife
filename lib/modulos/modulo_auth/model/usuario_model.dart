class Usuario {
  final String nombre;
  final String email;
  final String contrasena;

  Usuario({required this.nombre, required this.email, required this.contrasena});

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'email': email,
      'contraseña': contrasena,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombre: json['nombre'],
      email: json['email'],
      contrasena: json['contraseña'],
    );
  }
}
