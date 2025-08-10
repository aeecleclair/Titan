import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/settings/class/notification_topic.dart';
import 'package:titan/settings/repositories/notification_topic_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class NotificationTopicNotifier extends ListNotifier<NotificationTopic> {
  final NotificationTopicRepository notificationTopicRepository =
      NotificationTopicRepository();
  NotificationTopicNotifier({required String token})
    : super(const AsyncValue.loading()) {
    notificationTopicRepository.setToken(token);
  }

  Future<AsyncValue<List<NotificationTopic>>>
  loadNotificationTopicList() async {
    return await loadList(
      () async => notificationTopicRepository.getAllNotificationTopic(),
    );
  }

  Future<bool> toggleSubscription(NotificationTopic topic) async {
    return await update(
      topic.isUserSubscribed
          ? notificationTopicRepository.unsubscribeTopic
          : notificationTopicRepository.subscribeTopic,
      (topics, topic) {
        topics[topics.indexWhere((t) => t.id == topic.id)] = topic.copyWith(
          isUserSubscribed: !topic.isUserSubscribed,
        );
        return topics;
      },
      topic,
    );
  }
}

final notificationTopicListProvider =
    StateNotifierProvider<
      NotificationTopicNotifier,
      AsyncValue<List<NotificationTopic>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = NotificationTopicNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadNotificationTopicList();
      });
      return notifier;
    });
