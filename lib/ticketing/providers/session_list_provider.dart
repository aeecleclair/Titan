import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/ticketing/class/session.dart';
import 'package:titan/ticketing/repositories/session_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SessionListNotifier extends ListNotifier<Session> {
  SessionRepository repository = SessionRepository();
  SessionListNotifier({required String token, required String categoryId})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Session>>> loadSessions(String categoryId) async {
    return await loadList(() => repository.getAllSession(categoryId));
  }

  Future<bool> addSession(Session session) async {
    return await add(repository.addSession, session);
  }

  Future<bool> updateSession(Session session) async {
    return await update(
      repository.updateSession,
      (sessions, session) =>
          sessions..[sessions.indexWhere((b) => b.id == session.id)] = session,
      session,
    );
  }

  Future<bool> deleteSession(Session session) async {
    return await delete(
      repository.deleteSession,
      (sessions, session) => sessions..removeWhere((b) => b.id == session.id),
      session.id,
      session,
    );
  }
}

final sessionListProvider =
    StateNotifierProvider<SessionListNotifier, AsyncValue<List<Session>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      SessionListNotifier notifier = SessionListNotifier(
        token: token,
        categoryId: '',
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadSessions('');
      });
      return notifier;
    });
