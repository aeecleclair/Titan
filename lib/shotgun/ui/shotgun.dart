import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/shotgun/providers/shotgun_on_back_provider.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/constants.dart';

class ShotgunTemplate extends HookConsumerWidget {
  final Widget child;
  const ShotgunTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onBack = ref.watch(shotgunOnBackProvider);

    VoidCallback? topBarOnBack;
    if (onBack != null) {
      topBarOnBack = () {
        ref.read(shotgunOnBackProvider.notifier).state = null;
        onBack();
      };
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ColorConstants.background),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(root: ShotgunRouter.root, onBack: topBarOnBack),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
