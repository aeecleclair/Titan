import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:myecl/tools/exception.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/logs/logger.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

abstract class LogoRepository {
  static final String host = getTitanHost();
  static const String expiredTokenDetail = "Could not validate credentials";
  final String ext = "";
  final Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };
  static final Logger logger = Logger();

  void setToken(String token) {
    headers["Authorization"] = 'Bearer $token';
  }

  Future<Uint8List> getLogo(String id, {String suffix = ""}) async {
    try {
      final response =
          await http.get(Uri.parse("$host$ext$id$suffix"), headers: headers);
      if (response.statusCode == 200) {
        try {
          return response.bodyBytes;
        } catch (e) {
          logger.error(
            "GET $ext$id$suffix\nError while decoding response",
          );
          rethrow;
        }
      } else if (response.statusCode == 403) {
        logger.error(
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
        logger.error(
          "GET $ext$id$suffix\n${response.statusCode} ${response.body}",
        );
        throw AppException(ErrorType.notFound, response.body);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      logger.error(
        "GET $ext$id$suffix\nCould not load the logo",
      );
      rethrow;
    }
  }

  Future<Uint8List> addLogo(
    Uint8List bytes,
    String id, {
    String suffix = "",
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$host$ext$id$suffix"),
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
          logger.error(
            "POST $ext$id$suffix\nError while decoding response",
          );
          throw AppException(ErrorType.invalidData, e.toString());
        }
      } else if (response.statusCode == 403) {
        logger.error(
          "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}",
        );
        throw AppException(ErrorType.tokenExpire, value);
      } else {
        logger.error(
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
        logger.error(
          "GET $path\nError while decoding response",
        );
        rethrow;
      }
    } else if (response.statusCode == 403) {
      logger.error(
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
      logger.error(
        "GET $path\n${response.statusCode} ${response.body}",
      );
      throw AppException(ErrorType.notFound, response.body);
    }
  }
}
