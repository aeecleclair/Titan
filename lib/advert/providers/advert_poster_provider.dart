import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class AdvertPosterNotifier extends SingleNotifier<Image> {
  Openapi get repository => ref.watch(repositoryProvider);
  AdvertPostersNotifier? _advertPostersNotifier;

  @override
  AsyncValue<Image> build() {
    _advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    return const AsyncValue.loading();
  }

  Future<Image> getAdvertPoster(String id) async {
    final response = await repository.advertAdvertsAdvertIdPictureGet(
      advertId: id,
    );
    final image = response.bodyBytes.isEmpty
        ? Image.asset(getTitanLogo())
        : Image.memory(response.bodyBytes);
    _advertPostersNotifier!.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateAdvertPoster(String id, Uint8List bytes) async {
    _advertPostersNotifier!.setTData(id, const AsyncLoading());
    await repository.advertAdvertsAdvertIdPicturePost(
      advertId: id,
      image: bytes,
    );
    final image = Image.memory(bytes);
    _advertPostersNotifier!.setTData(id, AsyncData([image]));
    return image;
  }
}

final advertPosterProvider =
    NotifierProvider<AdvertPosterNotifier, AsyncValue<Image>>(
      AdvertPosterNotifier.new,
    );
