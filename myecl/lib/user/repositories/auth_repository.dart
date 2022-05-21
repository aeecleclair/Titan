import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthTokenRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    "Accept": "application/json",
  };

  Future<String> getToken(String username, String password) async {
    try {
      final response = await http.post(Uri.parse(host + "auth/token"),
          headers: headers,
          encoding: Encoding.getByName('utf-8'),
          body: {
            "username": username,
            "password": password
          }).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["access_token"];
      } else {
        throw Exception('Wrong credentials');
      }
    } on TimeoutException catch (_) {
      throw Exception('No response from server');
    } catch (e) {
      rethrow;
    }
  }
}
