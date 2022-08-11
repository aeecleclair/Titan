import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class OrderRepository extends Repository {
  final ext = "orders/";

  Future<bool> updateOrder(String orderId, Order order) async {
    final response = await http.patch(Uri.parse(host + ext + orderId),
        headers: headers, body: json.encode(order.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to update order");
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    final response =
        await http.delete(Uri.parse(host + ext + orderId), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete order");
    }
  }

  Future<Order> getOrder(String orderId) async {
    final response =
        await http.get(Uri.parse(host + ext + orderId), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Order.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load order");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to get order");
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(order.toJson()));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Order.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create order");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to create order");
    }
  }
}
