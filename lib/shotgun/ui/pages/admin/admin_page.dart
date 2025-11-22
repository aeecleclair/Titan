import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text("Admin Page"));
  }
}
