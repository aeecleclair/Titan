import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/admin_module_page/account_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_module_page/tombola_handler.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminModulePage extends HookConsumerWidget {
  const AdminModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);

    return Refresher(
        onRefresh: () async {
          await () => {};
        },
        child: Column(
          children: [
            const AccountHandler(),
            const SizedBox(height: 12),
            const TombolaHandler()
          ],
        ));
  }
}
