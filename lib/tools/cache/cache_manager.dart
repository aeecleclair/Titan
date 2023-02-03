import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheManager {
  final storage = const FlutterSecureStorage();

  Future<String> readCache(String key) async {
    return await storage.read(key: key) ?? "";
  }

  Future<void> writeCache(String key, String value) async {
    return await storage.write(key: key, value: value);
  }

  Future<void> deleteCache(String key) async {
    return await storage.delete(key: key);
  }
}