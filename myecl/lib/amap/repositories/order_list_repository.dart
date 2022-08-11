import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class OrderListRepository extends Repository {
  final ext = "amap/deliveries/";

  Future<Order> createOrder(
      String deliveryId, Order order, String userId) async {
    Map<String, dynamic> orderJson = order.toJson();
    orderJson.addAll({
      "user_id": userId,
    });
    final response = await http.post(
        Uri.parse(host + ext + deliveryId + "/orders"),
        headers: headers,
        body: json.encode(orderJson));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Order.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create order");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create order");
    }
  }

  Future<bool> updateOrder(
      String deliveryId, Order order, String userId) async {
    Map<String, dynamic> orderJson = order.toJson();
    orderJson.addAll({
      "user_id": userId,
    });
    final response = await http.patch(
        Uri.parse(host + ext + deliveryId + "/orders"),
        headers: headers,
        body: json.encode(orderJson));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update order");
    }
  }

  Future<bool> deleteOrder(String deliveryId, String orderId) async {
    final response = await http.delete(
        Uri.parse(host + ext + deliveryId + "/orders/" + orderId),
        headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete order");
    }
  }

  Future<Order> getOrder(String deliveryId, String orderId) async {
    final response = await http.get(
        Uri.parse(host + ext + deliveryId + "/orders/" + orderId),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        return Order.fromJson(json.decode(response.body));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to get order");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to get order");
    }
  }
}
