class UserServiceModel {
  static int? id_usuario;
  static String? nombre;
  static String? email;
  static DateTime? birthday;
  static String? meta_hidratacion;
  static String? meta_deporte;
  static String? meta_sueno;
  static String? meta_alimentacion;
  
  static void clear() {
    id_usuario = null;
    nombre = null;
    email = null;
    birthday = null;
  }
}
