import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class AmapUserRepository extends Repository {
  final ext = "amap/users/";
  final List<Product> loadedProducts = <Product>[];

  Future<List<Order>> getOrderList(String userId) async {
    final response = await http.get(
        Uri.parse(host + "amap/users/" + userId + "/orders"),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Order>.from(
            json.decode(resp).map((x) => Order.fromJson(x)));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load orders");
    }
  }

  Future<Cash> getCashByUser(String userId) async {
    final response = await http.get(Uri.parse(host + ext + userId + "/cash"),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Cash.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load cash");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load cash");
    }
  }
}
