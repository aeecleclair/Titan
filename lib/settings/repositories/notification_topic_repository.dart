import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/settings/class/notification_topic.dart';
import 'package:titan/tools/repository/repository.dart';

class NotificationTopicRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "notification/";

  Future<List<NotificationTopic>> getAllNotificationTopic() async {
    return (await getList(
      suffix: 'topics',
    )).map((e) => NotificationTopic.fromJson(e)).toList();
  }

  Future<bool> subscribeTopic(NotificationTopic topic) async {
    return await create({}, suffix: "topics/${topic.id}/subscribe");
  }

  Future<bool> unsubscribeTopic(NotificationTopic topic) async {
    return await create({}, suffix: "topics/${topic.id}/unsubscribe");
  }
}

final notificationTopicRepositoryProvider =
    Provider<NotificationTopicRepository>((ref) {
      final token = ref.watch(tokenProvider);
      return NotificationTopicRepository()..setToken(token);
    });
