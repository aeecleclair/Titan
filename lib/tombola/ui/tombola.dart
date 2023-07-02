import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/tombola/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

class TombolaTemplate extends HookConsumerWidget {
  final Widget child;
  const TombolaTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationNotifier = ref.watch(animationProvider.notifier);
    final controller =
        ref.watch(swipeControllerProvider(animationNotifier.animation!));
    final controllerNotifier = ref
        .watch(swipeControllerProvider(animationNotifier.animation!).notifier);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: IgnorePointer(
            ignoring: controller.isCompleted,
            child: Column(
              children: [
                TopBar(
                  controllerNotifier: controllerNotifier,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
