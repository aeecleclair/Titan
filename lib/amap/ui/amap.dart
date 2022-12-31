import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/amap/ui/page_switcher.dart';

class AmapHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const AmapHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          switch (page) {
            case AmapPage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }
            case AmapPage.pres:
              pageNotifier.setAmapPage(AmapPage.main);
              break;
            case AmapPage.addProducts:
              pageNotifier.setAmapPage(AmapPage.main);
              break;
            case AmapPage.admin:
              pageNotifier.setAmapPage(AmapPage.main);
              break;
            case AmapPage.addEditProduct:
              pageNotifier.setAmapPage(AmapPage.admin);
              break;
            case AmapPage.addEditDelivery:
              pageNotifier.setAmapPage(AmapPage.admin);
              break;
          }
          return false;
        },
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: IgnorePointer(
              ignoring: controller.isCompleted,
              child: Column(
                children: [
                  TopBar(
                    controllerNotifier: controllerNotifier,
                  ),
                  const Expanded(child: PageSwitcher()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
