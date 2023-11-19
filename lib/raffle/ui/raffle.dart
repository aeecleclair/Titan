import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

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
          Expanded(child: child)
        ],
      ),
    );
  }
}
