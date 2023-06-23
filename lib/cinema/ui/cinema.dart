import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/cinema/ui/top_bar.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaTemplate extends ConsumerWidget {
  final Widget child;
  const CinemaTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationNotifier = ref.watch(animationProvider.notifier);
    final controller =
        ref.watch(swipeControllerProvider(animationNotifier.animation!));
    final controllerNotifier = ref
        .watch(swipeControllerProvider(animationNotifier.animation!).notifier);
    return Scaffold(
      body: (QR.currentPath != CinemaRouter.root + CinemaRouter.detail)
          ? IgnorePointer(
              ignoring: controller.isCompleted,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TopBar(
                      controllerNotifier: controllerNotifier,
                    ),
                    Expanded(child: child)
                  ],
                ),
              ),
            )
          : IgnorePointer(ignoring: controller.isCompleted, child: child),
    );
  }
}
