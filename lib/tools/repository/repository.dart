import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:myecl/tools/logs/logger.dart';

abstract class Repository {
  final String host = dotenv.env[kDebugMode ? "DEBUG_HOST" : "RELEASE_HOST"]!;
  static final String displayHost =
      dotenv.env[kDebugMode ? "DEBUG_HOST" : "RELEASE_HOST"]!;
  static const String expiredTokenDetail = "Could not validate credentials";
  final String ext = "";
  final Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };
  final cacheManager = CacheManager();
  static final Logger logger = Logger();

  void initLogger() {
    logger.init();
  }

  void setToken(String token) {
    headers["Authorization"] = 'Bearer $token';
  }

  /// GET ext/suffix
  Future<List> getList({String suffix = ""}) async {
    try {
      final response =
          await http.get(Uri.parse(host + ext + suffix), headers: headers);
      if (response.statusCode == 200) {
        try {
          String toDecode = response.body;
          if (host == displayHost) {
            toDecode = utf8.decode(response.body.runes.toList());
          }
          cacheManager.writeCache(ext + suffix, toDecode);
          return jsonDecode(toDecode);
        } catch (e) {
          logger.writeLog(Log(
              message: "GET ${ext + suffix}\nError while decoding response",
              level: LogLevel.error));
          return [];
        }
      } else if (response.statusCode == 403) {
        logger.writeLog(Log(
            message:
                "GET ${ext + suffix}\n${response.statusCode} ${response.body}",
            level: LogLevel.error));
        try {
          String toDecode = response.body;
          if (host == displayHost) {
            toDecode = utf8.decode(response.body.runes.toList());
          }
          final decoded = jsonDecode(toDecode);
          if (decoded["detail"] == expiredTokenDetail) {
            throw AppException(ErrorType.tokenExpire, decoded["detail"]);
          } else {
            throw AppException(ErrorType.notFound, decoded["detail"]);
          }
        } on AppException {
          rethrow;
        } catch (e) {
          logger.writeLog(Log(
              message: "GET ${ext + suffix}\nError while decoding response",
              level: LogLevel.error));

          throw AppException(ErrorType.notFound, response.body);
        }
      } else {
        logger.writeLog(Log(
            message:
                "GET ${ext + suffix}\n${response.statusCode} ${response.body}",
            level: LogLevel.error));
        throw AppException(ErrorType.notFound, response.body);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      try {
        final toDecode = await cacheManager.readCache(ext + suffix);
        return jsonDecode(toDecode);
      } catch (e) {
        logger.writeLog(Log(
            message:
                "GET ${ext + suffix}\nError while decoding response from cache",
            level: LogLevel.error));
        cacheManager.deleteCache(ext + suffix);
        return [];
      }
    }
  }

  /// Get ext/id/suffix
  Future<dynamic> getOne(String id, {String suffix = ""}) async {
    try {
      final response =
          await http.get(Uri.parse(host + ext + id + suffix), headers: headers);
      if (response.statusCode == 200) {
        try {
          String toDecode = response.body;
          if (host == displayHost) {
            toDecode = utf8.decode(response.body.runes.toList());
          }
          cacheManager.writeCache(ext + id + suffix, toDecode);
          return jsonDecode(toDecode);
        } catch (e) {
          logger.writeLog(Log(
              message:
                  "GET ${ext + id + suffix}\nError while decoding response",
              level: LogLevel.error));
          return <String, dynamic>{};
        }
      } else if (response.statusCode == 403) {
        logger.writeLog(Log(
            message:
                "GET ${ext + id + suffix}\n${response.statusCode} ${response.body}",
            level: LogLevel.error));
        try {
          String toDecode = response.body;
          if (host == displayHost) {
            toDecode = utf8.decode(response.body.runes.toList());
          }
          final decoded = jsonDecode(toDecode);
          if (decoded["detail"] == expiredTokenDetail) {
            throw AppException(ErrorType.tokenExpire, decoded["detail"]);
          } else {
            throw AppException(ErrorType.notFound, decoded["detail"]);
          }
        } on AppException {
          rethrow;
        } catch (e) {
          logger.writeLog(Log(
              message:
                  "GET ${ext + id + suffix}\nError while decoding response",
              level: LogLevel.error));
          throw AppException(ErrorType.notFound, response.body);
        }
      } else {
        logger.writeLog(Log(
            message:
                "GET ${ext + id + suffix}\n${response.statusCode} ${response.body}",
            level: LogLevel.error));
        throw AppException(ErrorType.notFound, response.body);
      }
    } on AppException {
      rethrow;
    } catch (e) {
      try {
        final toDecode = await cacheManager.readCache(ext + id + suffix);
        return jsonDecode(toDecode);
      } catch (e) {
        logger.writeLog(Log(
            message:
                "GET ${ext + id + suffix}\nError while decoding response from cache",
            level: LogLevel.error));
        cacheManager.deleteCache(ext + suffix);
        return [];
      }
    }
  }

  /// POST ext/suffix
  Future<dynamic> create(dynamic t, {String suffix = ""}) async {
    final response = await http.post(Uri.parse(host + ext + suffix),
        headers: headers, body: jsonEncode(t));
    if (response.statusCode == 201) {
      try {
        String toDecode = response.body;
        if (host == displayHost) {
          toDecode = utf8.decode(response.body.runes.toList());
        }
        return jsonDecode(toDecode);
      } catch (e) {
        logger.writeLog(Log(
            message: "POST ${ext + suffix}\nError while decoding response",
            level: LogLevel.error));
        throw AppException(ErrorType.invalidData, e.toString());
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      logger.writeLog(Log(
          message:
              "POST ${ext + suffix}\n${response.statusCode} ${response.body}",
          level: LogLevel.error));
      String toDecode = response.body;
      if (host == displayHost) {
        toDecode = utf8.decode(response.body.runes.toList());
      }
      final decoded = jsonDecode(toDecode);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      logger.writeLog(Log(
          message:
              "POST ${ext + suffix}\n${response.statusCode} ${response.body}",
          level: LogLevel.error));
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  /// PATCH ext/id/suffix
  Future<bool> update(dynamic t, String tId, {String suffix = ""}) async {
    final response = await http.patch(Uri.parse(host + ext + tId + suffix),
        headers: headers, body: jsonEncode(t));
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      logger.writeLog(Log(
          message:
              "PATCH ${ext + tId + suffix}\n${response.statusCode} ${response.body}",
          level: LogLevel.error));
      String toDecode = response.body;
      if (host == displayHost) {
        toDecode = utf8.decode(response.body.runes.toList());
      }
      final decoded = jsonDecode(toDecode);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      logger.writeLog(Log(
          message:
              "PATCH ${ext + tId + suffix}\n${response.statusCode} ${response.body}",
          level: LogLevel.error));
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  /// DELETE ext/id/suffix
  Future<bool> delete(String tId, {String suffix = ""}) async {
    final response = await http.delete(Uri.parse(host + ext + tId + suffix),
        headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      logger.writeLog(Log(
          message:
              "DELETE ${ext + tId + suffix}\n${response.statusCode} ${response.body}",
          level: LogLevel.error));
      String toDecode = response.body;
      if (host == displayHost) {
        toDecode = utf8.decode(response.body.runes.toList());
      }
      final decoded = jsonDecode(toDecode);
      if (decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(ErrorType.notFound, decoded["detail"]);
      }
    } else {
      logger.writeLog(Log(
          message:
              "DELETE ${ext + tId + suffix}\n${response.statusCode} ${response.body}",
          level: LogLevel.error));
      throw AppException(ErrorType.notFound, response.body);
    }
  }
}
