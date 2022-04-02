import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/amap/providers/parser.dart';
import '../models/order.dart';


const String url = '/orders';


Future<Order> getOrder(String id) async {
  var resp = await http.get(Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'});
  return parseOrder(resp.body);
}