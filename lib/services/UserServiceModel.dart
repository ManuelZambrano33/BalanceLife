class UserServiceModel {
  static int? id_usuario;
  static String? nombre;
  static String? email;
  static DateTime? birthday;

  static void clear() {
    id_usuario = null;
    nombre = null;
    email = null;
    birthday = null;
  }
}
