import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/cinema/adapters/session.dart';

class SessionListNotifier extends ListNotifierAPI<CineSessionComplete> {
  final Openapi sessionRepository;
  SessionListNotifier({required this.sessionRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CineSessionComplete>>> loadSessions() async {
    return await loadList(sessionRepository.cinemaSessionsGet);
  }

  Future<bool> addSession(CineSessionBase session) async {
    return await add(
      () => sessionRepository.cinemaSessionsPost(body: session),
      session,
    );
  }

  Future<bool> updateSession(CineSessionComplete session) async {
    return await update(
      () => sessionRepository.cinemaSessionsSessionIdPatch(
        sessionId: session.id,
        body: session.toCineSessionUpdate(),
      ),
      (session) => session.id,
      session,
    );
  }

  Future<bool> deleteSession(String sessionId) async {
    return await delete(
      () =>
          sessionRepository.cinemaSessionsSessionIdDelete(sessionId: sessionId),
      (s) => s.id,
      sessionId,
    );
  }
}

final sessionListProvider = StateNotifierProvider<SessionListNotifier,
    AsyncValue<List<CineSessionComplete>>>((ref) {
  final sessionRepository = ref.watch(repositoryProvider);
  return SessionListNotifier(
    sessionRepository: sessionRepository,
  )..loadSessions();
});
