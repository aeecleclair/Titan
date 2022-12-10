import 'dart:io';

import 'package:f_logs/model/flog/flog.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/user.dart';
import 'package:http/http.dart' as http;

class UserRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<User> getUser(String userId) async {
    return User.fromJson(await getOne(userId));
  }

  Future<User> getMe() async {
    return User.fromJson(await getOne("me"));
  }

  Future<bool> deleteUser(String userId) async {
    return await delete(userId);
  }

  Future<bool> updateUser(User user) async {
    return await update(user, user.id);
  }

  Future<bool> updateMe(User user) async {
    return await update(user, "me");
  }

  Future<User> createUser(User user) async {
    return User.fromJson(await create(user));
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, String mail) async {
    try {
      return (await create({
        "old_password": oldPassword,
        "new_password": newPassword,
        "email": mail
      }, suffix: "change-password"))["success"];
    } catch (e) {
      return false;
    }
  }

  Future<Uint8List> getProfilePicture(String userId) async {
    final response = await http.get(
        Uri.parse("${Repository.host}$ext$userId/profile-picture/"),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        return response.bodyBytes;
      } catch (e) {
        FLog.error(
            text:
                "GET $ext$userId/profile-picture/\nError while decoding response",
            exception: e);
        rethrow;
      }
    } else if (response.statusCode == 403) {
      FLog.error(
          text:
              "GET $ext$userId/profile-picture/\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      FLog.error(
          text:
              "GET $ext$userId/profile-picture/\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  Future<Uint8List> addProfilePicture(String path) async {
    final bytes = await File(path).readAsBytes();
    final request = http.MultipartRequest(
        'POST', Uri.parse("${Repository.host}${ext}me/profile-picture"))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', path,
          contentType: MediaType('image', 'jpeg')));
    final response = await request.send();
    if (response.statusCode == 201) {
      return bytes.buffer.asUint8List();
    } else if (response.statusCode == 403) {
      FLog.error(
          text:
              "POST ${ext}me/profile-picture/\n${response.statusCode} ${response.reasonPhrase}");
      throw AppException(ErrorType.tokenExpire, response.reasonPhrase ?? "");
    } else {
      FLog.error(
          text:
              "POST $ext{ext}me/profile-picture/\n${response.statusCode} ${response.reasonPhrase}");
      throw AppException(ErrorType.notFound, response.reasonPhrase ?? "");
    }
  }

  Future<bool> deletePersonalData() async {
    try {
      return await create({}, suffix: "me/ask-deletion");
    } catch (e) {
      return false;
    }
  }
}
