import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/session_poster_map_provider.dart';
import 'package:titan/cinema/repositories/session_poster_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class SessionPosterProvider extends SingleNotifier<Image> {
  final SessionPosterRepository repository;
  final SessionLogoNotifier sessionLogoNotifier;
  SessionPosterProvider({
    required this.repository,
    required this.sessionLogoNotifier,
  }) : super(const AsyncValue.loading());

  Future<Image> getLogo(String id) async {
    final image = await repository.getSessionLogo(id);
    sessionLogoNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    final image = await repository.addSessionLogo(bytes, id);
    sessionLogoNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final sessionPosterProvider =
    StateNotifierProvider<SessionPosterProvider, AsyncValue<Image>>((ref) {
      final sessionPoster = ref.watch(sessionPosterRepository);
      final sessionPosterMapNotifier = ref.watch(
        sessionPosterMapProvider.notifier,
      );
      return SessionPosterProvider(
        repository: sessionPoster,
        sessionLogoNotifier: sessionPosterMapNotifier,
      );
    });
