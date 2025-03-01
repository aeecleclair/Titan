import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TopicsProvider extends ListNotifierAPI<String> {
  final Openapi notificationRepository;
  TopicsProvider({required this.notificationRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> getTopics() async {
    return await loadList(notificationRepository.notificationTopicsGet);
  }

  Future<bool> subscribeTopic(String topic) async {
    return await update(
      () => notificationRepository.notificationTopicsTopicStrSubscribePost(
          topicStr: topic),
      (listT, t) => listT..add(t),
      topic,
    );
  }

  Future<bool> unsubscribeTopic(String topic) async {
    return await update(
      () => notificationRepository.notificationTopicsTopicStrUnsubscribePost(
          topicStr: topic),
      (listT, t) => listT..remove(t),
      topic,
    );
  }

  Future<bool> toggleSubscription(String topic) async {
    return state.maybeWhen(
      data: (data) {
        if (data.contains(topic)) {
          return unsubscribeTopic(topic);
        }
        return subscribeTopic(topic);
      },
      orElse: () => false,
    );
  }

  Future<bool> fakeSubscribeTopic(String topic) async {
    return await localUpdate((listT, t) => listT..add(t), topic);
  }

  Future<bool> fakeUnsubscribeTopic(String topic) async {
    return await localUpdate(
      (listT, t) => listT..remove(t),
      topic,
    );
  }

  Future<bool> fakeToggleSubscription(String topic) async {
    return state.maybeWhen(
      data: (data) {
        if (data.contains(topic)) {
          return fakeUnsubscribeTopic(topic);
        }
        return fakeSubscribeTopic(topic);
      },
      orElse: () => false,
    );
  }

  Future subscribeAll() async {
    return await state.maybeWhen(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          subscribeTopic(value[i]);
        }
      },
      orElse: () {},
    );
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
