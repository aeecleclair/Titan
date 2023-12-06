import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/service/class/topic.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TopicsProvider extends ListNotifier2<String> {
  final Openapi notificationRepository;
  TopicsProvider({required this.notificationRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> getTopics() async {
    return await loadList(notificationRepository.notificationTopicsGet);
  }

  Future<bool> subscribeTopic(String topic) async {
    return await update(
        (topicStr) async => notificationRepository
            .notificationTopicsTopicStrSubscribePost(topicStr: topicStr),
        (listT, t) => listT..add(t),
        topic.toString());
  }

  Future<bool> unsubscribeTopic(Topic topic) async {
    return await update(
        (topicStr) async => notificationRepository
            .notificationTopicsTopicStrUnsubscribePost(topicStr: topicStr),
        (listT, t) => listT..remove(t),
        topic.toString());
  }

  Future<bool> toggleSubscription(Topic topic) async {
    return state.maybeWhen(
        data: (data) {
          if (data.contains(topic.toString())) {
            return unsubscribeTopic(topic);
          }
          return subscribeTopic(topic.toString());
        },
        orElse: () => false);
  }

  Future subscribeAll() async {
    return await state.maybeWhen(
        data: (value) {
          for (var i = 0; i < value.length; i++) {
            subscribeTopic(value[i]);
          }
        },
        orElse: () {});
  }
}

final topicsProvider =
    StateNotifierProvider<TopicsProvider, AsyncValue<List<String>>>((ref) {
  final notificationRepository = ref.watch(repositoryProvider);
  TopicsProvider notifier =
      TopicsProvider(notificationRepository: notificationRepository);
  tokenExpireWrapperAuth(ref, () async {
    notifier.getTopics();
  });
  return notifier;
});
