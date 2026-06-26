import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/repositories/advert_poster_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class AdvertPosterNotifier extends SingleNotifier<Image> {
  AdvertPosterRepository get advertPosterRepository =>
      ref.watch(advertPosterRepositoryProvider);
  AdvertPostersNotifier? _advertPostersNotifier;

  @override
  AsyncValue<Image> build() {
    _advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    return const AsyncValue.loading();
  }

  Future<Image> getAdvertPoster(String id) async {
    final image = await advertPosterRepository.getAdvertPoster(id);
    _advertPostersNotifier!.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateAdvertPoster(String id, Uint8List bytes) async {
    _advertPostersNotifier!.setTData(id, const AsyncLoading());
    final image = await advertPosterRepository.addAdvertPoster(bytes, id);
    _advertPostersNotifier!.setTData(id, AsyncData([image]));
    return image;
  }
}

final advertPosterProvider =
    NotifierProvider<AdvertPosterNotifier, AsyncValue<Image>>(
      AdvertPosterNotifier.new,
    );
