import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/cinema/repositories/cinema_topic_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class CinemaTopicsProvider extends ListNotifier<String> {
  final CinemaTopicRepository cinemaTopicRepository = CinemaTopicRepository();
  CinemaTopicsProvider({required String token})
    : super(const AsyncValue.loading()) {
    cinemaTopicRepository.setToken(token);
  }

  Future<AsyncValue<List<String>>> getTopics() async {
    return await loadList(cinemaTopicRepository.getCinemaTopics);
  }

  Future<bool> subscribeSession(String topic) async {
    return await update(
      cinemaTopicRepository.subscribeSession,
      (listT, t) => listT..add(t),
      topic,
    );
  }

  Future<bool> unsubscribeSession(String topic) async {
    return await update(
      cinemaTopicRepository.unsubscribeSession,
      (listT, t) => listT..remove(t),
      topic,
    );
  }

  Future<bool> toggleSubscription(String topic) async {
    return state.maybeWhen(
      data: (data) {
        if (data.contains(topic)) {
          return unsubscribeSession(topic);
        }
        return subscribeSession(topic);
      },
      orElse: () => false,
    );
  }
}

final cinemaTopicsProvider =
    StateNotifierProvider<CinemaTopicsProvider, AsyncValue<List<String>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      CinemaTopicsProvider notifier = CinemaTopicsProvider(token: token);
      tokenExpireWrapperAuth(ref, () async {
        notifier.getTopics();
      });
      return notifier;
    });
