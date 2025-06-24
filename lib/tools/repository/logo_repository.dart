import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

abstract class LogoRepository extends Repository {
  static const String expiredTokenDetail = "Could not validate credentials";

  Future<Uint8List> getLogo(String id, {String suffix = ""}) async {
    try {
      final response = await http.get(
        Uri.parse("${Repository.host}$ext$id$suffix"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        try {
          return response.bodyBytes;
        } catch (e) {
          Repository.logger.error(
            "GET $ext$id$suffix\nError while decoding response",
          );
          rethrow;
        }
      } else if (response.statusCode == 403) {
        Repository.logger.error(
          "GET $ext$id$suffix\n${response.statusCode} ${response.body}",
        );
        String resp = utf8.decode(response.body.runes.toList());
        final decoded = json.decode(resp);
        if (decoded["detail"] == expiredTokenDetail) {
          throw AppException(ErrorType.tokenExpire, decoded["detail"]);
        } else {
          throw AppException(ErrorType.notFound, decoded["detail"]);
        }
      } else {
        Repository.logger.error(
          "GET $ext$id$suffix\n${response.statusCode} ${response.body}",
        );
        throw AppException(ErrorType.notFound, response.body);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      Repository.logger.error("GET $ext$id$suffix\nCould not load the logo");
      rethrow;
    }
  }

  Future<Uint8List> addLogo(
    Uint8List bytes,
    String id, {
    String suffix = "",
  }) async {
    final request =
        http.MultipartRequest(
            'POST',
            Uri.parse("${Repository.host}$ext$id$suffix"),
          )
          ..headers.addAll(headers)
          ..files.add(
            http.MultipartFile.fromBytes(
              'image',
              bytes,
              filename: 'image',
              contentType: MediaType('image', 'jpeg'),
            ),
          );
    final response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      if (response.statusCode == 201) {
        try {
          return json.decode(value)["success"];
        } catch (e) {
          Repository.logger.error(
            "POST $ext$id$suffix\nError while decoding response",
          );
          throw AppException(ErrorType.invalidData, e.toString());
        }
      } else if (response.statusCode == 403) {
        Repository.logger.error(
          "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}",
        );
        throw AppException(ErrorType.tokenExpire, value);
      } else {
        Repository.logger.error(
          "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}",
        );
        throw AppException(ErrorType.notFound, value);
      }
    });
    return bytes;
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
        Repository.logger.error("GET $path\nError while decoding response");
        rethrow;
      }
    } else if (response.statusCode == 403) {
      Repository.logger.error(
        "GET $path\n${response.statusCode} ${response.body}",
      );
      String resp = utf8.decode(response.body.runes.toList());
      final decoded = json.decode(resp);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      Repository.logger.error(
        "GET $path\n${response.statusCode} ${response.body}",
      );
      throw AppException(ErrorType.notFound, response.body);
    }
  }
}
