import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthTokenRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept": "application/json",
  };

  Future<String> getToken(String username, String password) async {
    final response = await http.post(Uri.parse(host + "auth/login/"),
        headers: headers,
        body: {"username": username, "password": password});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["token"];
    } else {
      throw Exception('Failed to load users');
    }
  }
}
