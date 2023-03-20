import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/flap/ui/home_page.dart';
import 'package:myecl/flap/ui/top_bar.dart';

class FlapHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const FlapHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        if (!controller.isCompleted) {
          controllerNotifier.toggle();
        } else {
          return true;
        }
        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: IgnorePointer(
            ignoring: controller.isCompleted,
            child: Stack(
              children: [
                const GamePage(),
                TopBar(
                  controllerNotifier: controllerNotifier,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
