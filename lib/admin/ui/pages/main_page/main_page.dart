import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';

import 'package:titan/user/providers/user_list_provider.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userList);

    return AdminTemplate(
      child: Padding(padding: const EdgeInsets.all(40), child: Text("yo")),
    );
  }
}
