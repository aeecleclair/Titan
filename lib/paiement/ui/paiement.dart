import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/paiement/ui/page_switcher.dart';
import 'package:myecl/paiement/providers/paiement_page_provider.dart';

class PaiementHomePage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const PaiementHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(paiementPageProvider);
    final pageNotifier = ref.watch(paiementPageProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case PaiementPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
          case PaiementPage.scan:
            pageNotifier.setPaiementPage(PaiementPage.main);
            break;
          case PaiementPage.pay:
            pageNotifier.setPaiementPage(PaiementPage.main);
            break;
          case PaiementPage.qr:
            pageNotifier.setPaiementPage(PaiementPage.main);
            break;
        }
        return false;
      },
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(
              controllerNotifier: controllerNotifier,
            ),
            const PageSwitcher()
          ],
        ),
      ),
    ));
  }
}
