import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class ListLogoRepository {
  final Openapi client;
  ListLogoRepository(this.client);

  Future<Image> getListLogo(String id) async {
    final response = await client.campaignListsListIdLogoGet(listId: id);
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addListLogo(Uint8List bytes, String id) async {
    await client.campaignListsListIdLogoPost(listId: id, image: bytes);
    return Image.memory(bytes);
  }
}

final listLogoRepositoryProvider = Provider<ListLogoRepository>(
  (ref) => ListLogoRepository(ref.watch(repositoryProvider)),
);
