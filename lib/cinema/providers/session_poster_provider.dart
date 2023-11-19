import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/repositories/session_poster_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class SessionPosterProvider extends SingleNotifier<Image> {
  final SessionPosterRepository repository;
  SessionPosterProvider({required this.repository})
      : super(const AsyncValue.loading());

  Future<Image> getLogo(String id) async {
    return await repository.getSessionLogo(id);
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    return await repository.addSessionLogo(bytes, id);
  }
}

final sessionPosterProvider =
    StateNotifierProvider<SessionPosterProvider, AsyncValue<Image>>((ref) {
  final sessionPoster = ref.watch(sessionPosterRepository);
  return SessionPosterProvider(repository: sessionPoster);
});
