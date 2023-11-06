import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/raffle/ui/pages/admin_module_page/account_handler.dart';
import 'package:myecl/raffle/ui/pages/admin_module_page/tombola_handler.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class AdminModulePage extends HookConsumerWidget {
  const AdminModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return RaffleTemplate(
      child: Refresher(
          onRefresh: () async {
            () => {};
          },
          child: const Column(
            children: [
               AccountHandler(),
               SizedBox(height: 12),
               TombolaHandler()
            ],
          )),
    );
  }
}
