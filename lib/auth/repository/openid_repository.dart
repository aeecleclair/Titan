import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/auth/class/auth_request.dart';
import 'package:myecl/auth/class/auth_token.dart';

import 'package:myecl/tools/repository/repository.dart';

class OpenIdRepository extends Repository {
  OpenIdRepository(super.ref);

  Future<AuthToken> getToken(AuthRequest request) async {
    final body = request.toJson();

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
        return AuthToken.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
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

final openIdRepositoryProvider = Provider((ref) {
  // No need to watch tokenProvider here, as the OpenIdRepository does not require a token.
  return OpenIdRepository(ref);
});
