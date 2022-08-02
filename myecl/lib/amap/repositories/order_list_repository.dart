import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/order.dart';

class OrderListRepository {
  final host = "http://10.0.2.2:8000/";
  final ext = "amap/deliveries/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

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
      String resp = utf8.decode(response.body.runes.toList());
      return Order.fromJson(json.decode(resp));
    } else {
      throw Exception("Failed to create order");
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
    } else {
      throw Exception("Failed to update order");
    }
  }

  Future<bool> deleteOrder(String deliveryId, String orderId) async {
    final response = await http.delete(
        Uri.parse(host + ext + deliveryId + "/orders/" + orderId),
        headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Failed to delete order");
    }
  }

  Future<Order> getOrder(String deliveryId, String orderId) async {
    final response = await http.get(
        Uri.parse(host + ext + deliveryId + "/orders/" + orderId),
        headers: headers);
    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load order");
    }
  }
}
