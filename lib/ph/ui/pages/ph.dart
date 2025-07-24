import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/constants.dart';

class PhTemplate extends HookConsumerWidget {
  final Widget child;
  const PhTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ColorConstants.background),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopBar(root: PhRouter.root),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
