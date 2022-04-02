import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/amap/providers/parser.dart';
import '../models/product.dart';

class ProductProvider {

  static const String url = '/products';

  Future<List<Product>> getProduits() async {
    var resp = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json'});
    return parseProduits(resp.body);
  }

  Future<int> createProduit(Product product) async {
    var resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editProduit(Product product) async {
    var resp = await http.put(
      Uri.parse('$url/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteProduit(String id) async {
    var resp = await http.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<Product> getProduit(String id) async {
    var resp = await http.get(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return parseProduit(resp.body);
  }
}