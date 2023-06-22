import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';
import 'package:myecl/home/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(eventPageProvider);
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final hasScrolledNotifier = ref.watch(hasScrolledProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case EventPage.main:
                            controllerNotifier.toggle();
                            break;
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
                      },
                      icon: HeroIcon(
                        page == EventPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(EventTextConstants.title,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
