import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class CinemaTopicsProvider extends ListNotifierAPI<TopicUser> {
  Openapi get cinemaTopicRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<TopicUser>> build() {
    getTopics();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<TopicUser>>> getTopics() async {
    return await loadList(cinemaTopicRepository.notificationTopicsGet);
  }

  Future<bool> subscribeSession(TopicUser topic) async {
    return await update(
      () => cinemaTopicRepository.notificationTopicsTopicIdSubscribePost(
        topicId: topic.id,
      ),
      (topic) => topic.id,
      topic,
    );
  }

  Future<bool> unsubscribeSession(TopicUser topic) async {
    return await update(
      () => cinemaTopicRepository.notificationTopicsTopicIdUnsubscribePost(
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
          return unsubscribeSession(topic);
        }
        return subscribeSession(topic);
      },
      orElse: () => false,
    );
  }
}

final cinemaTopicsProvider =
    NotifierProvider<CinemaTopicsProvider, AsyncValue<List<TopicUser>>>(
      CinemaTopicsProvider.new,
    );
