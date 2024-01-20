import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/tricount/tools/constants.dart';
import 'package:myecl/tricount/router.dart';

class TricountTemplate extends HookConsumerWidget {
  final Widget child;
  const TricountTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(
            title: TricountTextConstants.tricount,
            root: TricountRouter.root,
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
