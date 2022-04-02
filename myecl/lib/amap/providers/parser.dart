import 'dart:convert';

import '../models/delivery.dart';
import '../models/order.dart';
import '../models/product.dart';

Order parseOrder(String resp) {
  var jsonData = json.decode(resp);
  return Order.fromJson(jsonData);
}

List<Order> parseOrders(String resp) {
  final jsonData = json.decode(resp);
  return (jsonData as List).map((data) => Order.fromJson(data)).toList();
}

Delivery parseDelivery(String resp) {
  var jsonData = json.decode(resp);
  return Delivery.fromJson(jsonData);
}

List<Delivery> parseDeliveries(String resp) {
  final jsonData = json.decode(resp);
  return (jsonData as List).map((data) => Delivery.fromJson(data)).toList();
}

Product parseProduit(String resp) {
  var jsonData = json.decode(resp);
  return Product.fromJson(jsonData);
}

List<Product> parseProduits(String resp) {
  final jsonData = json.decode(resp);
  return (jsonData as List).map((data) => Product.fromJson(data)).toList();
}
