import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SessionListNotifier extends ListNotifier2<CineSessionComplete> {
  final Openapi sessionRepository;
  SessionListNotifier({required this.sessionRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CineSessionComplete>>> loadSessions() async {
    return await loadList(sessionRepository.cinemaSessionsGet);
  }

  Future<bool> addSession(CineSessionBase session) async {
    return await add(() => sessionRepository.cinemaSessionsPost(body: session), session);
  }

  Future<bool> updateSession(CineSessionComplete session) async {
    return await update(
      () => sessionRepository.cinemaSessionsSessionIdPatch(sessionId: session.id, body: CineSessionUpdate(
        name: session.name,
        start: session.start,
        duration: session.duration,
        overview: session.overview,
        genre: session.genre,
        tagline: session.tagline,
      )),
      (sessions, session) =>
          sessions..[sessions.indexWhere((b) => b.id == session.id)] = session,
      session,
    );
  }

  Future<bool> deleteSession(CineSessionComplete session) async {
    return await delete(
      () => sessionRepository.cinemaSessionsSessionIdDelete(sessionId: session.id),
      (sessions, session) => sessions..removeWhere((b) => b.id == session.id),
      session,
    );
  }
}

final sessionListProvider =
    StateNotifierProvider<SessionListNotifier, AsyncValue<List<CineSessionComplete>>>(
        (ref) {
  final sessionRepository = ref.watch(repositoryProvider);
  SessionListNotifier notifier = SessionListNotifier(
    sessionRepository: sessionRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadSessions();
  });
  return notifier;
});
