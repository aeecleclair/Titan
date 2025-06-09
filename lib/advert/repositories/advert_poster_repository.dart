import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class AdvertPosterRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "advert/";

  AdvertPosterRepository(super.ref);

  Future<Image> getAdvertPoster(String id) async {
    final uint8List = await getLogo("", suffix: "adverts/$id/picture");
    if (uint8List.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAdvertPoster(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, "", suffix: "adverts/$id/picture");
    return Image.memory(uint8List);
  }
}

final advertPosterRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return AdvertPosterRepository(ref)..setToken(token);
});
