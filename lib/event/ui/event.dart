import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/ui/page_switcher.dart';
import 'package:myecl/event/ui/top_bar.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';

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
    final appPageNotifier = ref.watch(pageProvider.notifier);
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
          case EventPage.addEvent:
            pageNotifier.setEventPage(EventPage.main);
            break;
          case EventPage.eventDetailfromModule:
            pageNotifier.setEventPage(EventPage.main);
            break;
          case EventPage.eventDetailfromCalendar:
            appPageNotifier.setPage(ModuleType.home);
            pageNotifier.setEventPage(EventPage.main);
            hasScrolledNotifier.setHasScrolled(true);
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
