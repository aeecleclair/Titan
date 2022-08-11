import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class DeliveryProductListRepository extends Repository {
  final ext = "amap/deliveries/";

  Future<List<Product>> getProductList(String deliveryId) async {
    final response = await http.get(
        Uri.parse(host + ext + deliveryId + "/products"),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Product>.from(
            json.decode(resp).map((x) => Product.fromJson(x)));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load products");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to load products");
    }
  }

  Future<Product> createProduct(String deliveryId, Product product) async {
    final response = await http.post(
        Uri.parse(host + ext + deliveryId + "/products"),
        headers: headers,
        body: json.encode(product.toJson()));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Product.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load products");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to load products");
    }
  }

  Future<bool> updateProduct(String deliveryId, Product product) async {
    final response = await http.patch(
        Uri.parse(
            host + ext + deliveryId + "/products/" + product.id.toString()),
        headers: headers,
        body: json.encode(product.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to load products");
    }
  }

  Future<bool> deleteProduct(String deliveryId, String productId) async {
    final response = await http.delete(
        Uri.parse(host + ext + deliveryId + "/products/" + productId),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, "");
    } else {
      throw AppException(ErrorType.notFound, "Failed to load products");
    }
  }
}
