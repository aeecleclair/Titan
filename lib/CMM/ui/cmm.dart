import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/router.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class CMMTemplate extends HookConsumerWidget {
  final Widget child;
  const CMMTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: "CMM",
            root: CMMRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
