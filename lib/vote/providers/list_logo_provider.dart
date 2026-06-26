import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/vote/providers/list_logos_provider.dart';

class ListLogoProvider extends SingleNotifier<Image> {
  Openapi get repository => ref.watch(repositoryProvider);
  ListLogoNotifier get listLogosNotifier =>
      ref.watch(listLogosProvider.notifier);

  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  Future<Image> getLogo(String id) async {
    final response = await repository.campaignListsListIdLogoGet(listId: id);
    final image = response.bodyBytes.isEmpty
        ? Image.asset(getTitanLogo())
        : Image.memory(response.bodyBytes);
    listLogosNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    await repository.campaignListsListIdLogoPost(listId: id, image: bytes);
    final image = Image.memory(bytes);
    listLogosNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final listLogoProvider = NotifierProvider<ListLogoProvider, AsyncValue<Image>>(
  ListLogoProvider.new,
);
