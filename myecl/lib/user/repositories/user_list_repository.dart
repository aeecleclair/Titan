import 'dart:convert';

import 'package:myecl/user/class/list_users.dart';
import 'package:http/http.dart' as http;

class UserListRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  void setToken(String token) {
    headers["Authorization"] = "Bearer $token";
  }

  Future<List<SimpleUser>> getAllUsers() async {
    final response =
        await http.get(Uri.parse(host + "users/"), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<SimpleUser>.from(
          json.decode(resp).map((x) => SimpleUser.fromJson(x)));
    } else {
      throw Exception('Failed to load users');
    }
  }
}
