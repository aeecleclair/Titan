import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/session_poster_map_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionPosterProvider extends SingleNotifier<Image> {
  Openapi get repository => ref.watch(repositoryProvider);
  SessionLogoNotifier get sessionLogoNotifier =>
      ref.watch(sessionPosterMapProvider.notifier);

  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  Future<Image> getLogo(String id) async {
    final response = await repository.cinemaSessionsSessionIdPosterGet(
      sessionId: id,
    );
    final image = response.bodyBytes.isEmpty
        ? Image.asset(getTitanLogo())
        : Image.memory(response.bodyBytes);
    sessionLogoNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    await repository.cinemaSessionsSessionIdPosterPost(
      sessionId: id,
      image: bytes,
    );
    final image = Image.memory(bytes);
    sessionLogoNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final sessionPosterProvider =
    NotifierProvider<SessionPosterProvider, AsyncValue<Image>>(
      SessionPosterProvider.new,
    );
