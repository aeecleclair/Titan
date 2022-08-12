import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';

class UserRepository extends Repository {
  final ext = "users/";

  Future<List<SimpleUser>> getAllUsers() async {
    final response = await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<SimpleUser>.from(json.decode(resp));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load users");
    }
  }

  Future<User> getUser(String userId) async {
    final response =
        await http.get(Uri.parse(host + ext + userId), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return User.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load user");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load user");
    }
  }

  Future<User> getMe() async {
    final response =
        await http.get(Uri.parse(host + ext + "me"), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return User.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load user");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load user");
    }
  }

  Future<bool> deleteUser(String userId) async {
    final response =
        await http.delete(Uri.parse(host + ext + userId), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete user");
    }
  }

  Future<bool> updateUser(String userId, User user) async {
    final response = await http.patch(Uri.parse(host + ext + userId),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update user");
    }
  }

  Future<bool> updateMe(User user) async {
    final response = await http.patch(Uri.parse(host + ext + "me"),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update user");
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(user.toJson()));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return User.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create user");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create user");
    }
  }
}
