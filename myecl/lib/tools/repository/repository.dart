import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';

abstract class Repository {
  final host = "http://10.0.2.2:8000/";
  final ext = "";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

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
        // print(resp);
        return json.decode(resp);
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load items");
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
        return {};
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load item");
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
        throw AppException(ErrorType.invalidData, "Failed to create item");
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create item");
    }
  }

  /// PATCH ext/id/suffix
  Future<bool> update(dynamic t, String tId, {String suffix = ""}) async {
    final response = await http.patch(Uri.parse(host + ext + tId + suffix),
        headers: headers, body: json.encode(t));
    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update item");
    }
  }

  /// DELETE ext/id/suffix
  Future<bool> delete(String tId, {String suffix = ""}) async {
    final response = await http.delete(Uri.parse(host + ext + tId + suffix),
        headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete item");
    }
  }
}
