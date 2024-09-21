import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/sg/router.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class SgTemplate extends HookConsumerWidget {
  final Widget child;
  const SgTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: "Shotgun",
            root: ShotgunRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
