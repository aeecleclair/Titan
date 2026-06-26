import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class TombolaLogoRepository {
  final Openapi client;
  TombolaLogoRepository(this.client);

  Future<Image> getTombolaLogo(String id) async {
    final response = await client.tombolaRafflesRaffleIdLogoGet(raffleId: id);
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addTombolaLogo(Uint8List bytes, String id) async {
    await client.tombolaRafflesRaffleIdLogoPost(raffleId: id, image: bytes);
    return Image.memory(bytes);
  }
}

final tombolaLogoRepositoryProvider = Provider<TombolaLogoRepository>(
  (ref) => TombolaLogoRepository(ref.watch(repositoryProvider)),
);
