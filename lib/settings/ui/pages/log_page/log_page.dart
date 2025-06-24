import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/providers/logs_provider.dart';
import 'package:titan/settings/providers/logs_tab_provider.dart';
import 'package:titan/settings/ui/pages/log_page/log_tab.dart';
import 'package:titan/settings/ui/pages/log_page/notification_tab.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class LogPage extends HookConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsNotifier = ref.watch(logsProvider.notifier);
    final notificationLogsNotifier = ref.watch(
      notificationLogsProvider.notifier,
    );
    final logTab = ref.watch(logTabProvider);
    final logTabNotifier = ref.read(logTabProvider.notifier);

    Widget getTab(LogTabs tab) {
      switch (tab) {
        case LogTabs.log:
          return const LogTab();
        case LogTabs.notification:
          return const NotificationTab();
      }
    }

    return SettingsTemplate(
      child: Refresher(
        onRefresh: () async {
          await logsNotifier.getLogs();
          await notificationLogsNotifier.getLogs();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              HorizontalListView.builder(
                height: 40,
                items: LogTabs.values,
                itemBuilder: (context, item, i) => GestureDetector(
                  onTap: () {
                    logTabNotifier.setLogTabs(item);
                  },
                  child: ItemChip(
                    selected: logTab == item,
                    child: Text(
                      capitalize(item.name),
                      style: TextStyle(
                        color: logTab == item ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              getTab(logTab),
            ],
          ),
        ),
      ),
    );
  }
}
