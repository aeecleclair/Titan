import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/advert/repositories/advert_poster_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class AdvertPosterNotifier extends SingleNotifier<Image> {
  final advertPosterRepository = AdvertPosterRepository();
  final AdvertPostersNotifier advertPostersNotifier;
  AdvertPosterNotifier({
    required String token,
    required this.advertPostersNotifier,
  }) : super(const AsyncValue.loading()) {
    advertPosterRepository.setToken(token);
  }

  Future<Image> getAdvertPoster(String id) async {
    final image = await advertPosterRepository.getAdvertPoster(id);
    advertPostersNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateAdvertPoster(String id, Uint8List bytes) async {
    advertPostersNotifier.setTData(id, const AsyncLoading());
    final image = await advertPosterRepository.addAdvertPoster(bytes, id);
    advertPostersNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final advertPosterProvider =
    StateNotifierProvider<AdvertPosterNotifier, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
      return AdvertPosterNotifier(
        token: token,
        advertPostersNotifier: advertPostersNotifier,
      );
    });
