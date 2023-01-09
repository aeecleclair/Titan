import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';
import 'package:f_logs/f_logs.dart';

abstract class Repository {
  static const String host = "https://hyperion.myecl.fr/";
  static const String expiredTokenDetail = "Could not validate credentials";
  final String ext = "";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  LogsConfig config = FLog.getDefaultConfigurations()
    ..isDevelopmentDebuggingEnabled = true
    ..timestampFormat = TimestampFormat.TIME_FORMAT_24_FULL
    ..formatType = FormatType.FORMAT_CUSTOM
    ..fieldOrderFormatCustom = [
      FieldName.TIMESTAMP,
      FieldName.LOG_LEVEL,
      FieldName.CLASSNAME,
      FieldName.METHOD_NAME,
      FieldName.TEXT,
      FieldName.EXCEPTION,
      FieldName.STACKTRACE
    ];

  void initLogger() {
    FLog.applyConfigurations(config);
  }

  void setToken(String token) {
    headers["Authorization"] = 'Bearer $token';
  }

  /// GET ext/suffix
  Future<List> getList({String suffix = ""}) async {
    final response =
        await http.get(Uri.parse(host + ext + suffix), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return json.decode(resp);
      } catch (e) {
        FLog.error(
            text: "GET ${ext + suffix}\nError while decoding response",
            exception: e);
        return [];
      }
    } else if (response.statusCode == 403) {
      FLog.error(
          text: "GET ${ext + suffix}\n${response.statusCode} ${response.body}");
      try {
        String resp = utf8.decode(response.body.runes.toList());
        final decoded = json.decode(resp);
        if (decoded["detail"] == expiredTokenDetail) {
          throw AppException(ErrorType.tokenExpire, decoded["detail"]);
        } else {
          throw AppException(ErrorType.notFound, decoded["detail"]);
        }
      } catch (e) {
        FLog.error(
            text: "GET ${ext + suffix}\nError while decoding response",
            exception: e);
        throw AppException(ErrorType.notFound, response.body);
      }
    } else {
      FLog.error(
          text: "GET ${ext + suffix}\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  /// Get ext/id/suffix
  Future<dynamic> getOne(String id, {String suffix = ""}) async {
    final response =
        await http.get(Uri.parse(host + ext + id + suffix), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return json.decode(resp);
      } catch (e) {
        FLog.error(
            text: "GET ${ext + id + suffix}\nError while decoding response",
            exception: e);
        return {};
      }
    } else if (response.statusCode == 403) {
      FLog.error(
          text: "GET ${ext + suffix}\n${response.statusCode} ${response.body}");
        String resp = utf8.decode(response.body.runes.toList());
        final decoded = json.decode(resp);
        print(decoded);
        print(decoded["detail"]);
        if (decoded["detail"] == expiredTokenDetail) {
          print("token expired");
          throw AppException(ErrorType.tokenExpire, decoded["detail"]);
        } else {
          throw AppException(ErrorType.notFound, decoded["detail"]);
        }
    } else {
      FLog.error(
          text:
              "GET ${ext + id + suffix}\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  /// POST ext/suffix
  Future<dynamic> create(dynamic t, {String suffix = ""}) async {
    final response = await http.post(Uri.parse(host + ext + suffix),
        headers: headers, body: json.encode(t));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return json.decode(resp);
      } catch (e) {
        FLog.error(
            text: "POST ${ext + suffix}\nError while decoding response",
            exception: e);
        throw AppException(ErrorType.invalidData, e.toString());
      }
    } else if (response.statusCode == 204) {
      return true;
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
          text:
              "POST ${ext + suffix}\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }

  /// PATCH ext/id/suffix
  Future<bool> update(dynamic t, String tId, {String suffix = ""}) async {
    final response = await http.patch(Uri.parse(host + ext + tId + suffix),
        headers: headers, body: json.encode(t));
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
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
          text:
              "PATCH ${ext + tId + suffix}\n${response.statusCode} ${response.body}");
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
          text:
              "DELETE ${ext + tId + suffix}\n${response.statusCode} ${response.body}");
      throw AppException(ErrorType.notFound, response.body);
    }
  }
}
