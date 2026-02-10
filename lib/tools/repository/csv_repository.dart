import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:http/http.dart' as http;

abstract class CsvRepository extends Repository {
  static const String expiredTokenDetail = "Could not validate credentials";

  Future<Uint8List> getCsv(String id, {String suffix = ""}) async {
    try {
      final response = await http.get(
        Uri.parse("${Repository.host}$ext$id$suffix"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        try {
          return response.bodyBytes;
        } catch (e) {
          Repository.logger.writeLog(
            Log(
              message: "GET $ext$id$suffix\nError while decoding response",
              level: LogLevel.error,
            ),
          );
          rethrow;
        }
      } else if (response.statusCode == 403) {
        Repository.logger.writeLog(
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
        Repository.logger.writeLog(
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
      Repository.logger.writeLog(
        Log(
          message: "GET $ext$id$suffix\nCould not load the csv",
          level: LogLevel.error,
        ),
      );
      rethrow;
    }
  }
}
