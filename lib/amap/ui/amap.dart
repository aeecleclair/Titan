import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/tools/functions.dart';
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
            case AmapPage.products:
              clearCmd(ref);
              pageNotifier.setAmapPage(AmapPage.main);
              break;
            case AmapPage.admin:
              pageNotifier.setAmapPage(AmapPage.main);
              break;
            case AmapPage.modif:
              pageNotifier.setAmapPage(AmapPage.admin);
              break;
            case AmapPage.addCmd:
              pageNotifier.setAmapPage(AmapPage.admin);
              break;
            case AmapPage.delivery:
              pageNotifier.setAmapPage(AmapPage.main);
              break;
            case AmapPage.solde:
              pageNotifier.setAmapPage(AmapPage.admin);
              break;
            case AmapPage.addSolde:
              pageNotifier.setAmapPage(AmapPage.solde);
              break;
            case AmapPage.deliveryAdmin:
              pageNotifier.setAmapPage(AmapPage.admin);
              break;
            case AmapPage.deliveryOrder:
              pageNotifier.setAmapPage(AmapPage.deliveryAdmin);
              break;
          }
          return false;
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/test3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
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
    );
  }
}
