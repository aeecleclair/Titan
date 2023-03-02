import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/repositories/session_logo_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class SessionPosterProvider extends SingleNotifier<Image> {
  final repository = SessionPosterRepository();
  SessionPosterProvider({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {
    return await repository.getPretendenceLogo(id);
  }

  Future<Image> updateLogo(String id, String path) async {
    return await repository.addPretendenceLogo(path, id);
  }
}

final sessionPosterProvider =
    StateNotifierProvider<SessionPosterProvider, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  return SessionPosterProvider(token: token);
});
