import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/repositories/session_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class SessionListNotifier extends ListNotifier<Session> {
  final SessionRepository sessionRepository;
  SessionListNotifier({required this.sessionRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Session>>> loadSessions() async {
    return await loadList(sessionRepository.getAllSessions);
  }

  Future<bool> addSession(Session session) async {
    return await add(sessionRepository.addSession, session);
  }

  Future<bool> updateSession(Session session) async {
    return await update(
      sessionRepository.updateSession,
      (sessions, session) =>
          sessions..[sessions.indexWhere((b) => b.id == session.id)] = session,
      session,
    );
  }

  Future<bool> deleteSession(Session session) async {
    return await delete(
      sessionRepository.deleteSession,
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
      final sessionRepository = ref.watch(sessionRepositoryProvider);
      SessionListNotifier notifier = SessionListNotifier(
        sessionRepository: sessionRepository,
      );
      notifier.loadSessions();
      return notifier;
    });
