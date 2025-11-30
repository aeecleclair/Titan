import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/ticketing/class/session.dart';

class SessionNotifier extends StateNotifier<Session> {
  SessionNotifier() : super(Session.empty());

  void setSession(Session i) {
    state = i;
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, Session>((ref) {
  return SessionNotifier();
});
