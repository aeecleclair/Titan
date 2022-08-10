import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/tools/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';

class UserRepository extends Repository {
  final ext = "users/";

  Future<List<SimpleUser>> getAllUsers() async {
    final response =
        await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<SimpleUser>.from(json.decode(resp).map((x) => SimpleUser.fromJson(x)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUser(String userId) async {
    final response =
        await http.get(Uri.parse(host + ext + userId), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return User.fromJson(json.decode(resp));
    } else {
      throw Exception("Failed to load user");
    }
  }

  Future<bool> deleteUser(String userId) async {
    final response = await http.delete(Uri.parse(host + ext + userId),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete users");
    }
  }

  Future<bool> updateUser(String userId, User user) async {
    final response = await http.patch(Uri.parse(host + ext + userId),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update users");
    }
  }

  Future<bool> createUser(User user) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create users");
    }
  }
}
