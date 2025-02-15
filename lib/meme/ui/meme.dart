import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/router.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class MemeTemplate extends HookConsumerWidget {
  final Widget child;
  const MemeTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: "Meme",
            root: MemeRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
