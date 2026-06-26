import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/session_poster_map_provider.dart';
import 'package:titan/cinema/repositories/session_poster_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class SessionPosterProvider extends SingleNotifier<Image> {
  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  SessionPosterRepository get repository =>
      ref.watch(sessionPosterRepositoryProvider);
  SessionLogoNotifier get sessionLogoNotifier =>
      ref.watch(sessionPosterMapProvider.notifier);

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
    NotifierProvider<SessionPosterProvider, AsyncValue<Image>>(
      SessionPosterProvider.new,
    );
