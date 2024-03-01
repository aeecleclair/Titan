import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/advert/repositories/advert_poster_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class AdvertPosterNotifier extends SingleNotifier<Image> {
  final advertPosterRepository = AdvertPosterRepository();
  final AdvertPostersNotifier advertPostersNotifier;
  AdvertPosterNotifier(
      {required String token, required this.advertPostersNotifier})
      : super(const AsyncValue.loading()) {
    advertPosterRepository.setToken(token);
  }

  Future<Image> getAdvertPoster(String id) async {
    return await advertPosterRepository.getAdvertPoster(id).then((image) {
      advertPostersNotifier.setTData(id, AsyncData([image]));
      return image;
    });
  }

  Future<Image> updateAdvertPoster(String id, Uint8List bytes) async {
    advertPostersNotifier.setTData(id, const AsyncLoading());
    return await advertPosterRepository
        .addAdvertPoster(bytes, id)
        .then((image) {
      advertPostersNotifier.setTData(id, AsyncData([image]));
      return image;
    });
  }
}

final advertPosterProvider =
    StateNotifierProvider<AdvertPosterNotifier, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
  return AdvertPosterNotifier(
      token: token, advertPostersNotifier: advertPostersNotifier);
});
