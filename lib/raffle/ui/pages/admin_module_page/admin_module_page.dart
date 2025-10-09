import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/raffle/ui/pages/admin_module_page/account_handler.dart';
import 'package:titan/raffle/ui/pages/admin_module_page/tombola_handler.dart';
import 'package:titan/raffle/ui/raffle.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class AdminModulePage extends HookConsumerWidget {
  const AdminModulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
    return RaffleTemplate(
      child: Refresher(
        onRefresh: () async {
          tombolaLogosNotifier.resetTData();
        },
        child: const Column(
          children: [AccountHandler(), SizedBox(height: 12), TombolaHandler()],
        ),
      ),
    );
  }
}
