import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/tools/repository.dart';

class CashRepository extends Repository {
  final ext = "amap/users/";

  Future<List<Cash>> getCashList() async {
    final response =
        await http.get(Uri.parse(host + ext + "cash"), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<Cash>.from(json.decode(resp).map((x) => Cash.fromJson(x)));
    } else {
      throw Exception("Failed to load cash list");
    }
  }

  Future<bool> getCash(Cash cash, String userId) async {
    final response = await http.get(
      Uri.parse(host + ext + userId + "/cash"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      cash = Cash.fromJson(json.decode(resp));
      return true;
    } else {
      throw Exception("Failed to load cash");
    }
  }

  Future<Cash> createCash(Cash cash, String userId) async {
    final response = await http.post(Uri.parse(host + ext + userId + "/cash"),
        headers: headers, body: json.encode(cash.toJson()));
    if (response.statusCode == 201) {
      String resp = utf8.decode(response.body.runes.toList());
      return Cash.fromJson(json.decode(resp));
    } else {
      throw Exception("Failed to create cash");
    }
  }

  Future<bool> updateCash(Cash cash, String userId) async {
    final response = await http.patch(Uri.parse(host + ext + userId + "/cash"),
        headers: headers, body: json.encode(cash.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update cash");
    }
  }
}
