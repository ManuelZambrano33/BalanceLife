class GeneralEndpoint {

  static const String baseUrl = 'http://192.168.1.7:3000/api/'; // Cambia esto a tu URL base
  
  static String getEndpoint (String endpoint) {
    return '$baseUrl$endpoint';
  }

}