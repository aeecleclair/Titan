import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class NewsImageRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'feed/news/';

  Future<Image> getNewsImage(String id) async {
    final uint8List = await getLogo(id, suffix: "/image");
    if (uint8List.isEmpty) {
      throw Exception("No image found");
    }
    return Image.memory(uint8List);
  }

  Future<Image> addNewsImage(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, id, suffix: "/image");
    return Image.memory(uint8List);
  }
}

final newsImageRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return NewsImageRepository()..setToken(token);
});
