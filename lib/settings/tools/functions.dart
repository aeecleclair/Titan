import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/settings/class/notification_topic.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Map<String, List<NotificationTopic>> groupNotificationTopicsByModuleRoot(
  List<NotificationTopic> topics,
  WidgetRef ref,
  BuildContext context,
) {
  final Map<String, List<NotificationTopic>> tempGroups = {};
  final Map<String, List<NotificationTopic>> result = {};
  final allModules = ref.read(modulesProvider.notifier).allModules;
  for (final topic in topics) {
    tempGroups.putIfAbsent(topic.moduleRoot, () => []).add(topic);
  }

  final Map<String, String> rootToName = {
    for (final module in allModules)
      module.root.replaceFirst('/', ''): module.getName(context),
  };

  final List<NotificationTopic> singleTopics = [];

  tempGroups.forEach((moduleRoot, topicList) {
    if (topicList.length == 1) {
      singleTopics.addAll(topicList);
    } else {
      final moduleName = rootToName[moduleRoot] ?? moduleRoot;
      result[moduleName] = topicList;
    }
  });

  if (singleTopics.isNotEmpty) {
    result["others"] = singleTopics;
  }

  return result;
}

void openLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
  } else {
    throw 'Unable to open: $url';
  }
}
