import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/booking/ui/top_bar.dart';

class BookingTemplate extends HookConsumerWidget {
  final Widget child;
  const BookingTemplate(
      {Key? key, required this.child})
      : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TopBar(
                  controllerNotifier: controllerNotifier,
                ),
                Expanded(child: child)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
