import 'dart:convert';
import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

abstract class LogoRepository extends Repository {
  static const String expiredTokenDetail = "Could not validate credentials";

  Future<Uint8List> getLogo(String id, {String suffix = ""}) async {
    try {
      final response =
          await http.get(Uri.parse("$host$ext$id$suffix"), headers: headers);
      if (response.statusCode == 200) {
        try {
          await cacheManager.writeImage(ext + id + suffix, response.bodyBytes);
          return response.bodyBytes;
        } catch (e) {
          FLog.error(
              text: "GET $ext$id$suffix\nError while decoding response",
              exception: e);
          rethrow;
        }
      } else if (response.statusCode == 403) {
        FLog.error(
            text:
                "GET ${ext + suffix}\n${response.statusCode} ${response.body}");
        String resp = utf8.decode(response.body.runes.toList());
        final decoded = json.decode(resp);
        if (decoded["detail"] == expiredTokenDetail) {
          throw AppException(ErrorType.tokenExpire, decoded["detail"]);
        } else {
          throw AppException(ErrorType.notFound, decoded["detail"]);
        }
      } else {
        FLog.error(
            text:
                "GET $ext$id$suffix\n${response.statusCode} ${response.body}");
        throw AppException(ErrorType.notFound, response.body);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      try {
        return await cacheManager.readImage(ext + id + suffix);
      } catch (e) {
        FLog.error(
            text:
                "GET $ext$id$suffix\nError while decoding response from cache",
            exception: e);
        cacheManager.deleteCache(ext + id + suffix);
        rethrow;
      }
    }
  }

  Future<Uint8List> addLogo(String path, String id, {String suffix = ""}) async {
    final file = File(path);
    final request =
        http.MultipartRequest('POST', Uri.parse("$host$ext$id$suffix"))
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
    return file.readAsBytes();
  }

  Future<File> saveLogoToTemp(String path) async {
    final response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      try {
        Directory tempDir = await getTemporaryDirectory();
        File file = File(join(tempDir.path, 'temp.png'));
        await file.writeAsBytes(response.bodyBytes);
        return file;
      } catch (e) {
        FLog.error(
            text: "GET $path\nError while decoding response", exception: e);
        rethrow;
      }
    } else if (response.statusCode == 403) {
      FLog.error(text: "GET $path\n${response.statusCode} ${response.body}");
      String resp = utf8.decode(response.body.runes.toList());
      final decoded = json.decode(resp);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      FLog.error(text: "GET $path\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }
}
