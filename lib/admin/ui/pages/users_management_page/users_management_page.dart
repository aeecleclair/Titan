import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';

class UsersManagementPage extends HookConsumerWidget {
  const UsersManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminTemplate(
      child: Padding(padding: const EdgeInsets.all(40), child: Text("yo")),
    );
  }
}
