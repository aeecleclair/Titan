import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminHomePage extends HookConsumerWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text("AdminHomePage page");
  }
}
