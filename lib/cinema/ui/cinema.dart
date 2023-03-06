import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
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
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case CinemaPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              initialPageNotifier.reset();
              scrollNotifier.reset();
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
          case CinemaPage.addEditSession:
            pageNotifier.setCinemaPage(CinemaPage.admin);
            break;
        }
        return false;
      },
      child: (page != CinemaPage.detailFromAdminPage &&
              page != CinemaPage.detailFromMainPage)
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
