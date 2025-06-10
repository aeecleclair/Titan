import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/class/session.dart';

class SessionNotifier extends StateNotifier<Session> {
  SessionNotifier() : super(Session.empty());

  void setSession(Session event) {
    state = event;
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, Session>((ref) {
  return SessionNotifier();
});
