import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionPosterRepository {
  final Openapi client;
  SessionPosterRepository(this.client);

  Future<Image> getSessionLogo(String id) async {
    final response = await client.cinemaSessionsSessionIdPosterGet(
      sessionId: id,
    );
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addSessionLogo(Uint8List bytes, String id) async {
    await client.cinemaSessionsSessionIdPosterPost(sessionId: id, image: bytes);
    return Image.memory(bytes);
  }
}

final sessionPosterRepositoryProvider = Provider<SessionPosterRepository>(
  (ref) => SessionPosterRepository(ref.watch(repositoryProvider)),
);
