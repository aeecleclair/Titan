import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SeedDepositPage extends HookConsumerWidget {
  const SeedDepositPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
}
