import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';

class UserRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };


  Future<List<SimpleUser>> getAllUsers() async {
    final response =
        await http.get(Uri.parse(host + "users/"), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.map<SimpleUser>((json) => SimpleUser.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUser(String userId) async {
    final response =
        await http.get(Uri.parse(host + "users/" + userId), headers: headers);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load user");
    }
  }

  Future<bool> deleteUser(String userId) async {
    final response = await http.delete(Uri.parse(host + "users/" + userId),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete users");
    }
  }

  Future<bool> updateUser(String userId, User user) async {
    final response = await http.patch(Uri.parse(host + "users/" + userId),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update users");
    }
  }

  Future<bool> createUser(User user) async {
    final response = await http.post(Uri.parse(host + "users/"),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create users");
    }
  }
}
