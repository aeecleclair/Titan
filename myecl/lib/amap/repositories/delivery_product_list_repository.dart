import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/product.dart';

class DeliveryProductListRepository {
  final host = "http://10.0.2.2:8000/";
  final ext = "amap/deliveries/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<List<Product>> getProductList(String deliveryId) async {
    final response = await http.get(
        Uri.parse(host + ext + deliveryId + "/products"),
        headers: headers);
    if (response.statusCode == 200) {
      return List<Product>.from(
          json.decode(response.body).map((x) => Product.fromJson(x)));
    } else {
      throw Exception("Failed to load product list");
    }
  }

  Future<bool> createProduct(String deliveryId, Product product) async {
    final response = await http.post(
        Uri.parse(host + ext + deliveryId + "/products"),
        headers: headers,
        body: json.encode(product.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create product");
    }
  }

  Future<bool> updateProduct(String deliveryId, Product product) async {
    final response = await http.patch(
        Uri.parse(host +
            ext +
            "deliveries/" +
            deliveryId +
            "/products/" +
            product.id.toString()),
        headers: headers,
        body: json.encode(product.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update product");
    }
  }

  Future<bool> deleteProduct(String deliveryId, String productId) async {
    final response = await http.delete(
        Uri.parse(host + ext + deliveryId + "/products/" + productId),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete product");
    }
  }
}
