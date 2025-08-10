import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:load_switch/load_switch.dart';
import 'package:titan/settings/class/notification_topic.dart';
import 'package:titan/settings/providers/notification_topic_provider.dart';

class LoadSwitchTopic extends ConsumerWidget {
  const LoadSwitchTopic({super.key, required this.notificationTopic});
  final NotificationTopic notificationTopic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationTopicListNotifier = ref.watch(
      notificationTopicListProvider.notifier,
    );
    return LoadSwitch(
      value: notificationTopic.isUserSubscribed,
      future: () async {
        await notificationTopicListNotifier.toggleSubscription(
          notificationTopic,
        );
        return !notificationTopic.isUserSubscribed;
      },
      height: 30,
      width: 60,
      curveIn: Curves.easeInBack,
      curveOut: Curves.easeOutBack,
      animationDuration: const Duration(milliseconds: 500),
      switchDecoration: (value, _) => BoxDecoration(
        color: value ? Colors.red.withValues(alpha: 0.3) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: value
                ? Colors.red.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      spinColor: (value) => value ? Colors.red : Colors.grey,
      spinStrokeWidth: 2,
      thumbDecoration: (value, _) => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: value
                ? Colors.red.withValues(alpha: 0.2)
                : Colors.grey.shade200.withValues(alpha: 0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      onChange: (v) {},
      onTap: (v) {},
    );
  }
}
