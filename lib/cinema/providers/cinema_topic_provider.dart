import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CinemaTopicsProvider extends ListNotifier2<String> {
  final Openapi cinemaTopicRepository;
  final String topicStr = "cinema";
  CinemaTopicsProvider({required this.cinemaTopicRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> getTopics() async {
    return await loadList(() async => cinemaTopicRepository
        .notificationTopicsTopicStrGet(topicStr: topicStr));
  }

  Future<bool> subscribeSession(String topic) async {
    return await update(
        (topic) async =>
            cinemaTopicRepository.notificationTopicsTopicStrSubscribePost(
                topicStr: "${topicStr}_$topic"),
        (listT, t) => listT..add(t),
        topic);
  }

  Future<bool> unsubscribeSession(String topic) async {
    return await update(
        (topic) async =>
            cinemaTopicRepository.notificationTopicsTopicStrUnsubscribePost(
                topicStr: "${topicStr}_$topic"),
        (listT, t) => listT..remove(t),
        topic);
  }

  Future<bool> toggleSubscription(String topic) async {
    return state.maybeWhen(
        data: (data) {
          if (data.contains(topic)) {
            return unsubscribeSession(topic);
          }
          return subscribeSession(topic);
        },
        orElse: () => false);
  }
}

final cinemaTopicsProvider =
    StateNotifierProvider<CinemaTopicsProvider, AsyncValue<List<String>>>(
        (ref) {
  final cinemaTopicRepository = ref.watch(repositoryProvider);
  CinemaTopicsProvider notifier =
      CinemaTopicsProvider(cinemaTopicRepository: cinemaTopicRepository);
  tokenExpireWrapperAuth(ref, () async {
    notifier.getTopics();
  });
  return notifier;
});
