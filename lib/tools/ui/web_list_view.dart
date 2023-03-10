import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebListView extends HookConsumerWidget {
  final Widget child;
  const WebListView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (kIsWeb) {
    //   final outerController = useScrollController();
    //   final innerController = useScrollController();
    //   return ListView(
    //       controller: outerController,
    //       clipBehavior: Clip.none,
    //       children: [
    //         Listener(
    //             onPointerSignal: (event) {
    //               if (event is PointerScrollEvent) {
    //                 final offset = event.scrollDelta.dy;
    //                 innerController.jumpTo(innerController.offset + offset);
    //                 outerController.jumpTo(outerController.offset - offset);
    //               }
    //             },
    //             child: SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 controller: innerController,
    //                 clipBehavior: Clip.none,
    //                 physics: const BouncingScrollPhysics(),
    //                 child: child))
    //       ]);
    // } else {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          child: child);
    // }
  }
}
