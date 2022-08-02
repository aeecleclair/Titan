import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';

class AmapUserRepository {
  final host = "http://10.0.2.2:8000/";
  final ext = "amap/users/";
  final List<Product> loadedProducts = <Product>[];
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<List<Order>> getOrderList(String userId) async {
    final response = await http.get(
        Uri.parse(host + "amap/users/" + userId + "/orders"),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        List<Order> orders =
            List<Order>.from(json.decode(resp).map((x) => Order.fromJson(x)));
        return orders;
      } catch (e) {
        return [];
      }
    } else {
      throw Exception("Failed to load order list");
    }
  }

  Future<Cash> getCashByUser(String userId) async {
    final response = await http.get(Uri.parse(host + ext + userId + "/cash"),
        headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return Cash.fromJson(json.decode(resp));
    } else {
      throw Exception("Failed to load cash");
    }
  }
}
