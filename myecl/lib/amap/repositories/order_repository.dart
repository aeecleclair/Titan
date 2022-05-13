import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/order.dart';

class OrderRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<bool> updateOrder(String orderId, Order order) async {
    final response = await http.patch(Uri.parse(host + "orders/" + orderId),
        headers: headers, body: json.encode(order.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update orders");
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    final response = await http
        .delete(Uri.parse(host + "orders/" + orderId), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete orders");
    }
  }

  Future<Order> getOrder(String orderId) async {
    final response = await http.get(Uri.parse(host + "orders/" + orderId),
        headers: headers);
    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<bool> createOrder(Order order) async {
    final response = await http.post(Uri.parse(host + "orders/"),
        headers: headers, body: json.encode(order.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create orders");
    }
  }
}