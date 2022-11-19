import 'dart:convert';
import 'dart:io';

import 'package:f_logs/model/flog/flog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      String oldPassword, String newPassword, String userId) async {
    try {
      return (await create({
        "old_password": oldPassword,
        "new_password": newPassword,
        "user_id": userId
      }, suffix: "change-password"))["success"];
    } catch (e) {
      return false;
    }
  }

  Future<Image> getProfilePicture(String userId) async {
    print("${Repository.host}$ext$userId/profile-picture/");
    final response = await http.get(
        Uri.parse("${Repository.host}$ext$userId/profile-picture/"),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        return Image.memory(response.bodyBytes);
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

  Future<Image> addProfilePicture(String path) async {
    final file = File(path);
    final image = Image.file(file);
    final request = http.MultipartRequest(
        'POST', Uri.parse("${Repository.host}${ext}me/profile-picture"));
    request.files.add(http.MultipartFile.fromBytes(
        'file', file.readAsBytesSync(),
        filename: 'profile_picture.png'));
    final response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (response.statusCode == 201) {
        try {
          return json.decode(value)["success"];
        } catch (e) {
          FLog.error(
              text:
                  "POST ${ext}me/profile-picture\nError while decoding response",
              exception: e);
          throw AppException(ErrorType.invalidData, e.toString());
        }
      } else if (response.statusCode == 403) {
        FLog.error(
            text:
                "POST ${ext}me/profile-picture\n${response.statusCode} ${response.reasonPhrase}");
        throw AppException(ErrorType.tokenExpire, value);
      } else {
        FLog.error(
            text:
                "POST ${ext}me/profile-picture\n${response.statusCode} ${response.reasonPhrase}");
        throw AppException(ErrorType.notFound, value);
      }
    });
    return image;
  }
}
