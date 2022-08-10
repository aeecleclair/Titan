import 'dart:convert';

import 'package:myecl/loan/class/item.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/repository.dart';

class ItemRepository extends Repository {
  final ext = "loans/item/";

  Future<List<Item>> getItemList() async {
    final response = await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<Item>.from(json.decode(resp));
    } else {
      throw Exception("Failed to load item list");
    }
  }

  Future<bool> createItem(Item item) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(item));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create item");
    }
  }

  Future<bool> updateItem(Item item) async {
    final response = await http.patch(Uri.parse(host + ext + item.id),
        headers: headers, body: json.encode(item));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update item");
    }
  }

  Future<bool> deleteItem(Item item) async {
    final response =
        await http.delete(Uri.parse(host + ext + item.id), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete item");
    }
  }
}
