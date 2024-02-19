import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SessionLogoNotifier extends MapNotifier<Session, Image> {
  SessionLogoNotifier() : super();
}

final sessionPosterMapProvider = StateNotifierProvider<SessionLogoNotifier,
    AsyncValue<Map<Session, AsyncValue<List<Image>>?>>>((ref) {
  SessionLogoNotifier sessionLogoNotifier = SessionLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(sessionListProvider).maybeWhen(data: (session) {
      sessionLogoNotifier.loadTList(session);
      return sessionLogoNotifier;
    }, orElse: () {
      sessionLogoNotifier.loadTList([]);
      return sessionLogoNotifier;
    });
  });
  return sessionLogoNotifier;
});
