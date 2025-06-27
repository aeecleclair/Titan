import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvertTemplate extends HookConsumerWidget {
  final Widget child;
  const AdvertTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}
