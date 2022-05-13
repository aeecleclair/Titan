import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/product.dart';

class ProductRepository {
  final host = "http://10.0.2.2:8000/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<bool> updateProduct(String productId, Product product) async {
    final response = await http.patch(Uri.parse(host + "products/" + productId),
        headers: headers, body: json.encode(product.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update products");
    }
  }

  Future<bool> deleteProduct(String productId) async {
    final response = await http
        .delete(Uri.parse(host + "products/" + productId), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete products");
    }
  }

  Future<Product> getProduct(String productId) async {
    final response = await http.get(Uri.parse(host + "products/" + productId),
        headers: headers);
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<bool> createProduct(Product product) async {
    final response = await http.post(Uri.parse(host + "products/"),
        headers: headers, body: json.encode(product.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create products");
    }
  }
}
