import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class EventImageRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'calendar/events/';

  Future<Image> addEventImage(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, id, suffix: "/image");
    return Image.memory(uint8List);
  }

  Future<Image> getEventImage(String id) async {
    final uint8List = await getLogo(id, suffix: "/image");
    return Image.memory(uint8List);
  }
}

final eventImageRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return EventImageRepository()..setToken(token);
});
