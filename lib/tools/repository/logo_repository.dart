import 'dart:convert';
import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:http/http.dart' as http;

abstract class LogoRepository extends Repository {
  static const String expiredTokenDetail = "Could not validate credentials";

  Future<Image> getLogo(String id, {String suffix = ""}) async {
    final response = await http
        .get(Uri.parse("${Repository.host}$ext$id$suffix"), headers: headers);
    if (response.statusCode == 200) {
      try {
        return Image.memory(response.bodyBytes);
      } catch (e) {
        FLog.error(
            text: "GET $ext$id$suffix\nError while decoding response",
            exception: e);
        rethrow;
      }
    } else if (response.statusCode == 403) {
      FLog.error(
          text: "GET ${ext + suffix}\n${response.statusCode} ${response.body}");
      String resp = utf8.decode(response.body.runes.toList());
      final decoded = json.decode(resp);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      FLog.error(
          text: "GET $ext$id$suffix\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  Future<Image> addLogo(String path, String id, {String suffix = ""}) async {
    final file = File(path);
    final image = Image.file(file);
    final request = http.MultipartRequest(
        'POST', Uri.parse("${Repository.host}$ext$id$suffix"))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', path,
          contentType: MediaType('image', 'jpeg')));
    final response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      if (response.statusCode == 201) {
        try {
          return json.decode(value)["success"];
        } catch (e) {
          FLog.error(
              text: "POST $ext$id$suffix\nError while decoding response",
              exception: e);
          throw AppException(ErrorType.invalidData, e.toString());
        }
      } else if (response.statusCode == 403) {
        FLog.error(
            text:
                "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}");
        throw AppException(ErrorType.tokenExpire, value);
      } else {
        FLog.error(
            text:
                "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}");
        throw AppException(ErrorType.notFound, value);
      }
    });
    return image;
  }
}
