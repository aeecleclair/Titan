import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class ManagementGreenhousePage extends HookConsumerWidget {
  const ManagementGreenhousePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text("Management Page"),
    );
  }
}
