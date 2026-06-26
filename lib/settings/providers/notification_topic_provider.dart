import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class NotificationTopicNotifier extends ListNotifierAPI<TopicUser> {
  Openapi get notificationTopicRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<TopicUser>> build() {
    loadNotificationTopicList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<TopicUser>>> loadNotificationTopicList() async {
    return await loadList(notificationTopicRepository.notificationTopicsGet);
  }

  Future<bool> toggleSubscription(TopicUser topic) async {
    return await update(
      () => topic.isUserSubscribed
          ? notificationTopicRepository
                .notificationTopicsTopicIdUnsubscribePost(topicId: topic.id)
          : notificationTopicRepository.notificationTopicsTopicIdSubscribePost(
              topicId: topic.id,
            ),
      (topic) => topic.id,
      topic.copyWith(isUserSubscribed: !topic.isUserSubscribed),
    );
  }
}

final notificationTopicListProvider =
    NotifierProvider<NotificationTopicNotifier, AsyncValue<List<TopicUser>>>(
      NotificationTopicNotifier.new,
    );
