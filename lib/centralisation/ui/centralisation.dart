import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/providers/centralisation_page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/centralisation/ui/page_switcher.dart';
import 'package:myecl/centralisation/ui/top_bar.dart';

class CentralisationHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;

  const CentralisationHomePage({
    Key? key,
    required this.controllerNotifier,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(centralisationPageProvider);
    final pageNotifier = ref.watch(centralisationPageProvider.notifier);


    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          switch (page) {
            case CentralisationPage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }
          }
          return false;
        },
        child: Container(
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
                  const PageSwitcher(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
