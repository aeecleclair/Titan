import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/logs_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/help_page/log_card.dart';
import 'package:myecl/tools/refresher.dart';

class HelpPage extends HookConsumerWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsProvider);
    final logsNotifier = ref.watch(logsProvider.notifier);
    return Refresher(
        onRefresh: () async {
          await logsNotifier.getLogs();
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(SettingsTextConstants.logs,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 205, 205, 205))),
              ),
              const SizedBox(
                height: 20,
              ),
              logs.when(data: (data) {
                return Column(
                    children: data.map((e) => LogCard(log: e)).toList());
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, error: (e, s) {
                return const Center(
                  child: Text("Error"),
                );
              })
            ])));
  }
}
