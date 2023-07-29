import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/logs_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/log_page/log_card.dart';
import 'package:myecl/settings/ui/settings.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class LogPage extends HookConsumerWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsProvider);
    final logsNotifier = ref.watch(logsProvider.notifier);
    return SettingsTemplate(
      child: Refresher(
          onRefresh: () async {
            await logsNotifier.getLogs();
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(SettingsTextConstants.logs,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 149, 149, 149))),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: ((context) => CustomDialogBox(
                                title: SettingsTextConstants.deleting,
                                descriptions: SettingsTextConstants.deleteLogs,
                                onYes: (() async {
                                  logsNotifier.deleteLogs();
                                }))));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5))
                            ]),
                        child: const Row(
                          children: [
                            HeroIcon(HeroIcons.trash,
                                color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                AsyncChild(
                  value: logs,
                  builder: (context, data) => Column(
                      children: data.map((e) => LogCard(log: e)).toList()),
                ),
                const SizedBox(height: 20),
              ]))),
    );
  }
}
