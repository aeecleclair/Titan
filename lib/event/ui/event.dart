import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/ui/page_switcher.dart';
import 'package:myecl/event/ui/top_bar.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';
import 'package:myecl/home/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventHomePage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const EventHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(eventPageProvider);
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final hasScrolledNotifier = ref.watch(hasScrolledProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case EventPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
          case EventPage.addEditEventFromMain:
            pageNotifier.setEventPage(EventPage.main);
            break;
          case EventPage.addEditEventFromAdmin:
            pageNotifier.setEventPage(EventPage.admin);
            break;
          case EventPage.eventDetailfromModuleFromMain:
            pageNotifier.setEventPage(EventPage.main);
            break;
          case EventPage.eventDetailfromModuleFromAdmin:
            pageNotifier.setEventPage(EventPage.admin);
            break;
          case EventPage.eventDetailfromCalendar:
            QR.to(HomeRouter.root);
            pageNotifier.setEventPage(EventPage.main);
            hasScrolledNotifier.setHasScrolled(true);
            break;
          case EventPage.admin:
            pageNotifier.setEventPage(EventPage.main);
            break;
        }
        return false;
      },
      child: SafeArea(
        child: IgnorePointer(
          ignoring: controller.isCompleted,
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
      ),
    ));
  }
}
