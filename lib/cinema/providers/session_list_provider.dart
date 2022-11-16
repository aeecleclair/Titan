import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/repositories/session_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class SessionListNotifier extends ListNotifier<Session> {
  SessionRepository repository = SessionRepository();
  SessionListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Session>>> loadSessions() async {
    return await loadList(repository.getAllSessions);
  }

  Future<bool> addSession(Session session) async {
    return await add(repository.addSession, session);
  }

  Future<bool> updateSession(Session session) async {
    return await update(
        repository.updateSession,
        (sessions, session) => sessions
          ..[sessions.indexWhere((b) => b.id == session.id)] = session,
        session);
  }

  Future<bool> deleteSession(Session session) async {
    return await delete(
        repository.deleteSession,
        (sessions, session) => sessions..removeWhere((b) => b.id == session.id),
        session.id,
        session);
  }
}

final sessionListProvider =
    StateNotifierProvider<SessionListNotifier, AsyncValue<List<Session>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  SessionListNotifier notifier = SessionListNotifier(token: token);
  notifier.loadSessions();
  return notifier;
});
