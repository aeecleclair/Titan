import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

String generateRandomString(int len) {
  var r = Random.secure();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String hash(String data) {
  return sha256.convert(utf8.encode(data)).toString();
}

class OAuth2TokenRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    "Accept": "application/json",
  };

  final clientId = "client_id";
  final responseType = "code";
  final scope = "API";
  final state = generateRandomString(128);
  final codeVerifier = generateRandomString(128);

  Future<String> getLogInPage() async {
    final response = await http.post(
      Uri.parse(host + "auth/authorize"),
      headers: headers,
      body: {
        "client_id": clientId,
        "response_type": responseType,
        "state": state,
        "scope": scope,
        "code_challenge": hash(codeVerifier),
        "code_challenge_method": "S256",
        "redirect_uri": "http://127.0.0.1:8000/",
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to get login page");
    }
  }

  Future<String> authorizationFlow(String username, String password) async {
    var body = {
      "email": username,
      "password": password,
      "client_id": clientId,
      "response_type": responseType,
      "state": state,
      "scope": scope,
      "code_challenge": hash(codeVerifier),
      "code_challenge_method": "S256",
      "redirect_uri": "http://127.0.0.1:8000/",
    };
    try {
      final response = await http
          .post(
              Uri.parse(host + "auth/authorization-flow/authorize-validation"),
              headers: headers,
              body: body)
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 302) {
        throw Exception('Wrong credentials');
      }
      if (!response.headers.containsKey("location")) {
        throw Exception('location is not valid');
      }
      final location = response.headers["location"];
      if (location == null) {
        throw Exception('location is not valid');
      }
      final code = location.split("code=")[1].split('&')[0];
      final returnedState = location.split("state=")[1].split('&')[0];
      if (state == returnedState) {
        return code;
      } else {
        throw Exception('state is not valid');
      }
    } on TimeoutException catch (_) {
      throw Exception('No response from server');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> getTokens(String authorizationCode) async {
    var body = {
      "client_id": clientId,
      "code": authorizationCode,
      "redirect_uri": "",
      "scope": scope,
      "code_verifier": codeVerifier,
      "grant_type": "authorization_code",
    };
    try {
      final response = await http.post(Uri.parse(host + "auth/token"),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)["access_token"];
        final refreshToken = jsonDecode(response.body)["refresh_token"];
        // final refreshToken = "";
        return {"token": token, "refreshToken": refreshToken};
      } else {
        throw Exception('Wrong credentials');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> refreshTokens(String refreshToken) async {
    var body = {
      "client_id": clientId,
      "scope": scope,
      "refresh_token": refreshToken,
      "grant_type": "refresh_token",
    };
    try {
      final response = await http.post(Uri.parse(host + "auth/token"),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)["access_token"];
        final refreshToken = jsonDecode(response.body)["refresh_token"];
        return {"token": token, "refreshToken": refreshToken};
      } else {
        throw Exception('Wrong credentials');
      }
    } catch (e) {
      rethrow;
    }
  }
}
