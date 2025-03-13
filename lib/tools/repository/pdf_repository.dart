import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/logs/logger.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

abstract class PdfRepository {
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

  Future<Uint8List> getPdf(String id, {String suffix = ""}) async {
    try {
      final response =
          await http.get(Uri.parse("$host$ext$id$suffix"), headers: headers);
      if (response.statusCode == 200) {
        try {
          return response.bodyBytes;
        } catch (e) {
          logger.writeLog(
            Log(
              message: "GET $ext$id$suffix\nError while decoding response",
              level: LogLevel.error,
            ),
          );
          rethrow;
        }
      } else if (response.statusCode == 403) {
        logger.writeLog(
          Log(
            message:
                "GET $ext$id$suffix\n${response.statusCode} ${response.body}",
            level: LogLevel.error,
          ),
        );
        String resp = utf8.decode(response.body.runes.toList());
        final decoded = json.decode(resp);
        if (decoded["detail"] == expiredTokenDetail) {
          throw AppException(ErrorType.tokenExpire, decoded["detail"]);
        } else {
          throw AppException(ErrorType.notFound, decoded["detail"]);
        }
      } else {
        logger.writeLog(
          Log(
            message:
                "GET $ext$id$suffix\n${response.statusCode} ${response.body}",
            level: LogLevel.error,
          ),
        );
        throw AppException(ErrorType.notFound, response.body);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      logger.writeLog(
        Log(
          message: "GET $ext$id$suffix\nCould not load the pdf",
          level: LogLevel.error,
        ),
      );
      rethrow;
    }
  }

  Future<Uint8List> addPdf(
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
          'pdf',
          bytes,
          filename: 'pdf',
          contentType: MediaType('application', 'pdf'),
        ),
      );
    final response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      if (response.statusCode == 201) {
        try {
          return json.decode(value)["success"];
        } catch (e) {
          logger.writeLog(
            Log(
              message: "POST $ext$id$suffix\nError while decoding response",
              level: LogLevel.error,
            ),
          );
          throw AppException(ErrorType.invalidData, e.toString());
        }
      } else if (response.statusCode == 403) {
        logger.writeLog(
          Log(
            message:
                "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}",
            level: LogLevel.error,
          ),
        );
        throw AppException(ErrorType.tokenExpire, value);
      } else {
        logger.writeLog(
          Log(
            message:
                "POST $ext$id$suffix\n${response.statusCode} ${response.reasonPhrase}",
            level: LogLevel.error,
          ),
        );
        throw AppException(ErrorType.notFound, value);
      }
    });
    return bytes;
  }

  Future<File> savePdfToTemp(String path) async {
    final response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      try {
        Directory tempDir = await getTemporaryDirectory();
        File file = File(join(tempDir.path, 'temp.pdf'));
        await file.writeAsBytes(response.bodyBytes);
        return file;
      } catch (e) {
        logger.writeLog(
          Log(
            message: "GET $path\nError while decoding response",
            level: LogLevel.error,
          ),
        );
        rethrow;
      }
    } else if (response.statusCode == 403) {
      logger.writeLog(
        Log(
          message: "GET $path\n${response.statusCode} ${response.body}",
          level: LogLevel.error,
        ),
      );
      String resp = utf8.decode(response.body.runes.toList());
      final decoded = json.decode(resp);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      logger.writeLog(
        Log(
          message: "GET $path\n${response.statusCode} ${response.body}",
          level: LogLevel.error,
        ),
      );
      throw AppException(ErrorType.notFound, response.body);
    }
  }
}
