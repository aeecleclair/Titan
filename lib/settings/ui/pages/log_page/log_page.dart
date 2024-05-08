import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/logs_provider.dart';
import 'package:myecl/settings/ui/pages/log_page/log_tab.dart';
import 'package:myecl/settings/ui/settings.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class LogPage extends HookConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsNotifier = ref.watch(logsProvider.notifier);
    return SettingsTemplate(
      child: Refresher(
        onRefresh: () async {
          await logsNotifier.getLogs();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: LogTab(),
        ),
      ),
    );
  }
}
