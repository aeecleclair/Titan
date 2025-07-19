import 'package:titan/settings/class/notification_topic.dart';

Map<String, List<NotificationTopic>> groupNotificationTopicsByModuleRoot(
  List<NotificationTopic> topics,
) {
  final Map<String, List<NotificationTopic>> tempGroups = {};
  final Map<String, List<NotificationTopic>> result = {};

  for (final topic in topics) {
    tempGroups.putIfAbsent(topic.moduleRoot, () => []).add(topic);
  }

  final List<NotificationTopic> singleTopics = [];
  tempGroups.forEach((key, value) {
    if (value.length == 1) {
      singleTopics.addAll(value);
    } else {
      result[key] = value;
    }
  });

  if (singleTopics.isNotEmpty) {
    result[''] = singleTopics;
  }

  return result;
}
