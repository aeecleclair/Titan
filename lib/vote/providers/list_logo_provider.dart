import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/vote/providers/list_logos_provider.dart';
import 'package:titan/vote/repositories/list_logo_repository.dart';

class ListLogoProvider extends SingleNotifier<Image> {
  ListLogoRepository get listLogoRepository =>
      ref.watch(listLogoRepositoryProvider);
  ListLogoNotifier get listLogosNotifier =>
      ref.watch(listLogosProvider.notifier);

  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  Future<Image> getLogo(String id) async {
    return await listLogoRepository.getListLogo(id).then((image) {
      listLogosNotifier.setTData(id, AsyncData([image]));
      return image;
    });
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    final image = await listLogoRepository.addListLogo(bytes, id);
    listLogosNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final listLogoProvider = NotifierProvider<ListLogoProvider, AsyncValue<Image>>(
  ListLogoProvider.new,
);
