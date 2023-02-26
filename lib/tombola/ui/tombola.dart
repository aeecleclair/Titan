import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/ui/page_switcher.dart';
import 'package:myecl/tombola/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

import '../providers/tombola_page_provider.dart';

class TombolaHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const TombolaHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(tombolaPageProvider);
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          switch (page) {
            case TombolaPage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }

            case TombolaPage.addEditLots:
              pageNotifier.setTombolaPage(TombolaPage.addEdit);
              break;
            case TombolaPage.tombola:
              pageNotifier.setTombolaPage(TombolaPage.main);
              break;
            case TombolaPage.achats:
              pageNotifier.setTombolaPage(TombolaPage.tombola);
              break;
            case TombolaPage.admin:
              pageNotifier.setTombolaPage(TombolaPage.main);
              break;
            case TombolaPage.addEditTypeTickets:
              pageNotifier.setTombolaPage(TombolaPage.addEdit);
              break;
            case TombolaPage.simuTombola:
              pageNotifier.setTombolaPage(TombolaPage.simuTombola);
              break;
            case TombolaPage.addEdit:
              pageNotifier.setTombolaPage(TombolaPage.admin);
              break;
          }
          return false;
        },
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
    );
  }
}
