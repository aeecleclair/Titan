import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class SessionLogoNotifier extends MapNotifier<Session, Image> {
  SessionLogoNotifier() : super();
}

final sessionPosterMapProvider = StateNotifierProvider<SessionLogoNotifier,
    Map<Session, AsyncValue<List<Image>>?>>((ref) {
  SessionLogoNotifier sessionLogoNotifier = SessionLogoNotifier();
  return sessionLogoNotifier;
});
