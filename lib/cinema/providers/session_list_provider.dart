import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionListNotifier extends ListNotifierAPI<CineSessionComplete> {
  Openapi get sessionRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<CineSessionComplete>> build() {
    loadSessions();
    return const AsyncValue.loading();
  }

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
        body: CineSessionUpdate(
          name: session.name,
          start: session.start,
          duration: session.duration,
          overview: session.overview,
          genre: session.genre,
          tagline: session.tagline,
        ),
      ),
      (session) => session.id,
      session,
    );
  }

  Future<bool> deleteSession(CineSessionComplete session) async {
    return await delete(
      () => sessionRepository.cinemaSessionsSessionIdDelete(
        sessionId: session.id,
      ),
      (session) => session.id,
      session.id,
    );
  }
}

final sessionListProvider =
    NotifierProvider<
      SessionListNotifier,
      AsyncValue<List<CineSessionComplete>>
    >(SessionListNotifier.new);
