import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/advert/repositories/advert_poster_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class AdvertPosterNotifier extends SingleNotifier<Image> {
  final _advertPosterRepository = AdvertPosterRepository();
  AdvertPosterNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _advertPosterRepository.setToken(token);
  }

  Future<Image> getAdvertPoster(String id) async {
    return await _advertPosterRepository.getAdvertPoster(id);
  }

  Future<Image> updateAdvertPoster(String id, String path) async {
    return await _advertPosterRepository.addAdvertPoster(path, id);
  }
}

final advertPosterProvider =
    StateNotifierProvider<AdvertPosterNotifier, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  return AdvertPosterNotifier(token: token);
});