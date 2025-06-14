import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/repositories/advert_poster_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class AdvertPosterNotifier extends SingleNotifier<Image> {
  final AdvertPosterRepository advertPosterRepository;
  final AdvertPostersNotifier advertPostersNotifier;
  AdvertPosterNotifier({
    required this.advertPostersNotifier,
    required this.advertPosterRepository,
  }) : super(const AsyncValue.loading());

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
      final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
      return AdvertPosterNotifier(
        advertPostersNotifier: advertPostersNotifier,
        advertPosterRepository: ref.watch(advertPosterRepositoryProvider),
      );
    });
