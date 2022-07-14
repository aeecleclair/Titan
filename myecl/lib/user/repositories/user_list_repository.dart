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
    // if (!headers.containsKey("Authorization")) {
    //   throw Exception("No token");
    // }
    final response =
        await http.get(Uri.parse(host + "users/"), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.map<SimpleUser>((json) => SimpleUser.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
