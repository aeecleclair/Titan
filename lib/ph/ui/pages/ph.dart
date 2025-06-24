import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class PhTemplate extends HookConsumerWidget {
  final Widget child;
  const PhTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(title: "PH", root: PhRouter.root),
          Expanded(child: child),
        ],
      ),
    );
  }
}
