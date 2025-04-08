class GeneralEndpoint {
 
  static const String baseUrl = 'https://localhost:3000';

  static String getEndpoint(String endpoint) {
    return '$baseUrl$endpoint';
  }
}