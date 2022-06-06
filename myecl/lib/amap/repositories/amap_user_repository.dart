import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/delivery_list_repository.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';

class AmapUserRepository {
  final host = "http://10.0.2.2:8000/";
  final ext = "amap/users/";
  final productRepository = DeliveryProductListRepository();
  final deliveryRepository = DeliveryListRepository();
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
        List<Order> orders = List<Order>.from(
            json.decode(response.body).map((x) => Order.fromJson(x)));
        for (Order order in orders) {
          List<Product> products = await deliveryRepository
              .getAllProductsFromOrder(order.deliveryId, order.id);
          order.products = products;
        }
        return orders;
      } catch (e) {
        return [];
      }
    } else {
      throw Exception("Failed to load order list");
    }
  }

  Future<List<double>> getAllCash() async {
    final response =
        await http.get(Uri.parse(host + ext + "cash"), headers: headers);
    if (response.statusCode == 200) {
      return List<double>.from(json.decode(response.body));
    } else {
      throw Exception("Failed to load cash");
    }
  }

  Future<double> getAllCashByUser(String userId) async {
    final response = await http.get(Uri.parse(host + ext + userId + "/cash"),
        headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load cash");
    }
  }

  Future<bool> addCash(String userId, double cash) async {
    final response = await http.post(Uri.parse(host + ext + userId + "/cash"),
        headers: headers, body: json.encode(cash));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to add cash");
    }
  }
}
