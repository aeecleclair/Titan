import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/providers/logs_provider.dart';
import 'package:titan/settings/tools/constants.dart';
import 'package:titan/settings/ui/pages/log_page/log_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class NotificationTab extends HookConsumerWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(notificationLogsProvider);
    final logsNotifier = ref.watch(notificationLogsProvider.notifier);
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              SettingsTextConstants.notifications,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: ((context) => CustomDialogBox(
                    title: SettingsTextConstants.deleting,
                    descriptions: SettingsTextConstants.deleteNotificationLogs,
                    onYes: (() async {
                      logsNotifier.deleteLogs();
                    }),
                  )),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    HeroIcon(HeroIcons.trash, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        AsyncChild(
          value: logs,
          builder: (context, data) =>
              Column(children: data.map((e) => LogCard(log: e)).toList()),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
