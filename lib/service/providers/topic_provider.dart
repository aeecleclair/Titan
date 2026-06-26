import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TopicsProvider extends ListNotifierAPI<TopicUser> {
  Openapi get notificationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<TopicUser>> build() {
    getTopics();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<TopicUser>>> getTopics() async {
    return await loadList(notificationRepository.notificationTopicsGet);
  }

  Future<bool> subscribeTopic(TopicUser topic) async {
    return await update(
      () => notificationRepository.notificationTopicsTopicIdSubscribePost(
        topicId: topic.id,
      ),
      (topic) => topic.id,
      topic,
    );
  }

  Future<bool> unsubscribeTopic(TopicUser topic) async {
    return await update(
      () => notificationRepository.notificationTopicsTopicIdUnsubscribePost(
        topicId: topic.id,
      ),
      (topic) => topic.id,
      topic,
    );
  }

  Future<bool> toggleSubscription(TopicUser topic) async {
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

  Future<bool> fakeSubscribeTopic(TopicUser topic) async {
    return await localUpdate((topic) => topic.id, topic);
  }

  Future<bool> fakeUnsubscribeTopic(TopicUser topic) async {
    return await localUpdate((topic) => topic.id, topic);
  }

  Future<bool> fakeToggleSubscription(TopicUser topic) async {
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
    NotifierProvider<TopicsProvider, AsyncValue<List<TopicUser>>>(
      TopicsProvider.new,
    );
