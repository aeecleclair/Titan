import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/ticketing/providers/event_provider.dart';
import 'package:titan/ticketing/class/session.dart';
import 'package:titan/ticketing/repositories/session_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SessionListNotifier extends ListNotifier<Session> {
  SessionRepository repository = SessionRepository();
  SessionListNotifier({required String token, required String eventId})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Session>>> loadSessions(String eventId) async {
    state = const AsyncLoading();
    return await loadList(() => repository.getAllSession(eventId));
  }
}

final sessionListProvider =
    StateNotifierProvider<SessionListNotifier, AsyncValue<List<Session>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final eventId = ref.watch(eventProvider).id;
      SessionListNotifier notifier = SessionListNotifier(
        token: token,
        eventId: eventId,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadSessions(eventId);
      });
      return notifier;
    });
