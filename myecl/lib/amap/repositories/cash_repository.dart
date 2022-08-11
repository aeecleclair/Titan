import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class CashRepository extends Repository {
  final ext = "amap/users/";

  Future<List<Cash>> getCashList() async {
    final response =
        await http.get(Uri.parse(host + ext + "cash"), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Cash>.from(json.decode(resp).map((x) => Cash.fromJson(x)));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load cash");
    }
  }

  Future<bool> getCash(Cash cash, String userId) async {
    final response = await http.get(
      Uri.parse(host + ext + userId + "/cash"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        cash = Cash.fromJson(json.decode(resp));
        return true;
      } catch (e) {
        return false;
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load cash");
    }
  }

  Future<Cash> createCash(Cash cash, String userId) async {
    final response = await http.post(Uri.parse(host + ext + userId + "/cash"),
        headers: headers, body: json.encode(cash.toJson()));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Cash.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create cash");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create cash");
    }
  }

  Future<bool> updateCash(Cash cash, String userId) async {
    final response = await http.patch(Uri.parse(host + ext + userId + "/cash"),
        headers: headers, body: json.encode(cash.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update cash");
    }
  }
}
