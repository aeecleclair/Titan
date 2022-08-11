import 'dart:convert';

import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:http/http.dart' as http;

class UserListRepository extends Repository {
  final ext = "users/";

  Future<List<SimpleUser>> getAllUsers() async {
    final response = await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<SimpleUser>.from(
            json.decode(resp).map((x) => SimpleUser.fromJson(x)));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load users");
    }
  }
}
