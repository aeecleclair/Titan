abstract class Repository {
  final host ="http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  void setToken(String token) {
    headers["Authorization"] = 'Bearer $token';
  }
}