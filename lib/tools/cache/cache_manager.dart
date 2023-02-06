import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  Future<void> writeImage(String key, Uint8List bodyBytes) async {
    return await storage.write(key: key, value: bodyBytes.toString());
  }

  Future<void> deleteImage(String key) async {
    return await storage.delete(key: key);
  }

  Future<Image> readImage(String key) async {
    final String? bytes = await storage.read(key: key).then((value) => value);
    if (bytes == null) {
      Uint8List blankBytes = const Base64Codec().decode(
          "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
      Image.memory(
        blankBytes,
        height: 1,
      );
      return Image.memory(blankBytes);
    }
    final Uint8List uint8list = Uint8List.fromList(bytes.codeUnits);
    return Image.memory(uint8list);
  }
}
