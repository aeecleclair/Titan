import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/cinema/ui/page_switcher.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';

class CinemaHomePage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const CinemaHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(cinemaPageProvider);
    final pageNotifier = ref.watch(cinemaPageProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case CinemaPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
          case CinemaPage.admin:
            pageNotifier.setCinemaPage(CinemaPage.main);
            break;
          case CinemaPage.detailFromMainPage:
            pageNotifier.setCinemaPage(CinemaPage.main);
            break;
          case CinemaPage.detailFromAdminPage:
            pageNotifier.setCinemaPage(CinemaPage.admin);
            break;
          case CinemaPage.addSession:
            pageNotifier.setCinemaPage(CinemaPage.admin);
            break;
          case CinemaPage.editSession:
            pageNotifier.setCinemaPage(CinemaPage.admin);
            break;
        }
        return false;
      },
      child: (page != CinemaPage.detailFromAdminPage &&
              page != CinemaPage.detailFromMainPage)
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopBar(
                    controllerNotifier: controllerNotifier,
                  ),
                  const PageSwitcher()
                ],
              ),
            )
          : const PageSwitcher(),
    ));
  }
}
