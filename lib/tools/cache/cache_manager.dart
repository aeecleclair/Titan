import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  Future<String> readCache(String key) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(key) ?? "";
  }

  Future<void> writeCache(String key, String value) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  Future<void> deleteCache(String key) async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(key);
  }

  Future<void> writeImage(String key, Uint8List bodyBytes) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(key, bodyBytes.toString());
  }

  Future<void> deleteImage(String key) async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(key);
  }

  Future<Uint8List> readImage(String key) async {
    final storage = await SharedPreferences.getInstance();
    final String bytes = storage.getString(key) ?? "";
    if (bytes == "") {
      return Uint8List(0);
    }
    return Uint8List.fromList(List<int>.from(json.decode(bytes)));
  }
}
