import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/constants.dart';

class RaffleTemplate extends HookConsumerWidget {
  final Widget child;
  const RaffleTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(color: ColorConstants.background, child: child);
  }
}
