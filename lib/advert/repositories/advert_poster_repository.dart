import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class AdvertPosterRepository {
  final Openapi client;
  AdvertPosterRepository(this.client);

  Future<Image> getAdvertPoster(String id) async {
    final response = await client.advertAdvertsAdvertIdPictureGet(advertId: id);
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addAdvertPoster(Uint8List bytes, String id) async {
    await client.advertAdvertsAdvertIdPicturePost(advertId: id, image: bytes);
    return Image.memory(bytes);
  }
}

final advertPosterRepositoryProvider = Provider<AdvertPosterRepository>(
  (ref) => AdvertPosterRepository(ref.watch(repositoryProvider)),
);
