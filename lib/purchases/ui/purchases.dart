import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/purchases/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class PurchasesTemplate extends HookConsumerWidget {
  final Widget child;
  const PurchasesTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(
            title: PurchasesTextConstants.purchases,
            root: PurchasesRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
