import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/advert/repositories/advert_logo_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class AdvertPosterProvider extends SingleNotifier<Image> {
  final repository = AdvertPosterRepository();
  AdvertPosterProvider({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getAdvertLogo(String id) async {
    return await repository.getAdvertLogo(id);
  }

  Future<Image> updateAdvertLogo(String id, String path) async {
    return await repository.addAdvertLogo(path, id);
  }
}

final advertPosterProvider =
    StateNotifierProvider<AdvertPosterProvider, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  return AdvertPosterProvider(token: token);
});