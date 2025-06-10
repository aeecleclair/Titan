import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class RaffleTemplate extends HookConsumerWidget {
  final Widget child;
  const RaffleTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(
            title: RaffleTextConstants.raffle,
            root: RaffleRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
