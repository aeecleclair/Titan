import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/ui/pages/admin_module_page/account_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_module_page/tombola_handler.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminModulePage extends HookConsumerWidget {
  const AdminModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Refresher(
        onRefresh: () async {
          () => {};
        },
        child: const Column(
          children: [
             AccountHandler(),
             SizedBox(height: 12),
             TombolaHandler()
          ],
        ));
  }
}
