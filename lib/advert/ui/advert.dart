import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/ui/page_switcher.dart';
import 'package:myecl/advert/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

class AdvertHomePage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const AdvertHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(advertPageProvider);
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case AdvertPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
          case AdvertPage.admin:
            pageNotifier.setAdvertPage(AdvertPage.main);
            break;
          case AdvertPage.detailFromMainPage:
            pageNotifier.setAdvertPage(AdvertPage.main);
            break;
          case AdvertPage.detailFromAdminPage:
            pageNotifier.setAdvertPage(AdvertPage.admin);
            break;
          case AdvertPage.addEditAdvert:
            pageNotifier.setAdvertPage(AdvertPage.admin);
            break;
          case AdvertPage.addRemAnnouncer:
            pageNotifier.setAdvertPage(AdvertPage.main);
            break;
        }
        return false;
      },
      child: (page != AdvertPage.detailFromAdminPage &&
              page != AdvertPage.detailFromMainPage)
          ? IgnorePointer(
              ignoring: controller.isCompleted,
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
            )
          : IgnorePointer(
              ignoring: controller.isCompleted, child: const PageSwitcher()),
    ));
  }
}
