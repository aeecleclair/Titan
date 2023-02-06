import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SessionLogoNotifier extends MapNotifier<Session, Image> {
  SessionLogoNotifier({required String token}) : super(token: token);
}

final sessionPosterMapProvider = StateNotifierProvider<SessionLogoNotifier,
    AsyncValue<Map<Session, AsyncValue<List<Image>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  SessionLogoNotifier sessionLogoNotifier =
      SessionLogoNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(sessionListProvider).when(data: (session) {
      sessionLogoNotifier.loadTList(session);
      for (final l in session) {
        sessionLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return sessionLogoNotifier;
    }, error: (error, stackTrace) {
      sessionLogoNotifier.loadTList([]);
      return sessionLogoNotifier;
    }, loading: () {
      sessionLogoNotifier.loadTList([]);
      return sessionLogoNotifier;
    });
  });
  return sessionLogoNotifier;
});
