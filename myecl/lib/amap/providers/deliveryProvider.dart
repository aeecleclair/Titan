import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/amap/models/delivery.dart';
import 'package:myecl/amap/models/product.dart';
import 'package:myecl/amap/providers/parser.dart';
import '../models/order.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeliveryProvider {
  static const String url = '/deliveries';

  Future<Delivery> getDelivery(String id) async {
    var resp = await http.get(Uri.parse('$url/$id'),
        headers: {'Content-Type': 'application/json'});
    return parseDelivery(resp.body);
  }

  Future<int> createDelivery(Delivery delivery) async {
    var resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(delivery.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editDelivery(Delivery delivery) async {
    var resp = await http.put(
      Uri.parse('$url/${delivery.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(delivery.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteDelivery(String id) async {
    var resp = await http.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<List<Product>> getDeliveryProducts(String id) async {
    var resp = await http.get(Uri.parse('$url/$id/products'),
        headers: {'Content-Type': 'application/json'});
    return parseProduits(resp.body);
  }

  Future<int> createDeliveryProduct(String id, Product product) async {
    var resp = await http.post(
      Uri.parse('$url/$id/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editDeliveryProduct(String id, Product product) async {
    var resp = await http.put(
      Uri.parse('$url/$id/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteDeliveryProduct(String id, String productId) async {
    var resp = await http.delete(
      Uri.parse('$url/$id/products/$productId'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<List<Order>> getDeliveryOrders(String id) async {
    var resp = await http.get(Uri.parse('$url/$id/orders'),
        headers: {'Content-Type': 'application/json'});
    return parseOrders(resp.body);
  }

  Future<int> createDeliveryOrder(String id, Order order) async {
    var resp = await http.post(
      Uri.parse('$url/$id/orders'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editDeliveryOrder(String id, Order order) async {
    var resp = await http.put(
      Uri.parse('$url/$id/orders/${order.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteDeliveryOrder(String id, String orderId) async {
    var resp = await http.delete(
      Uri.parse('$url/$id/orders/$orderId'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }
}

class DeliveryProviderNotifier extends StateNotifier<DeliveryProvider> {
  DeliveryProviderNotifier(DeliveryProvider deliveryProvider)
      : super(deliveryProvider);
}

final deliveryProvider =
    StateNotifierProvider<DeliveryProviderNotifier, DeliveryProvider>((ref) {
  DeliveryProvider deliveryProvider = DeliveryProvider();
  return DeliveryProviderNotifier(deliveryProvider);
});
