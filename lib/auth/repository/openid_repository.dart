import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:titan/tools/repository/repository.dart';

class OpenIdRepository extends Repository {
  Future<Map<String, String>> getToken(
    String token,
    String clientId,
    String redirectUri,
    String codeVerifier,
    String grantType,
  ) async {
    var body = {
      "client_id": clientId,
      "code": token,
      "redirect_uri": redirectUri.toString(),
      "code_verifier": codeVerifier,
      "grant_type": grantType,
      "refresh_token": token,
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/json",
    };
    try {
      final response = await http
          .post(
            Uri.parse("${Repository.host}auth/token"),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)["access_token"];
        final refreshToken = jsonDecode(response.body)["refresh_token"];
        return {"token": token, "refresh_token": refreshToken};
      } else {
        throw Exception('Empty token');
      }
    } on TimeoutException catch (_) {
      throw Exception('No response from server');
    } catch (e) {
      rethrow;
    }
  }
}
