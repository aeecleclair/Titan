import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class SessionPosterRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/sessions/';

  SessionPosterRepository(super.ref);

  Future<Image> getSessionLogo(String id) async {
    final bytes = await getLogo(id, suffix: "/poster");
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addSessionLogo(Uint8List bytes, String id) async {
    return Image.memory(
      await addLogo(bytes, id, suffix: "/poster"),
      fit: BoxFit.cover,
    );
  }
}

final sessionPosterRepository = Provider<SessionPosterRepository>((ref) {
  return SessionPosterRepository(ref);
});
