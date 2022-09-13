import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(eventPageProvider);
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final appPageNotifier = ref.watch(pageProvider.notifier);
    final _hasScrolledNotifier = ref.watch(hasScrolledProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 42,
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
                          case EventPage.addEvent:
                            pageNotifier.setEventPage(EventPage.main);
                            break;
                          case EventPage.eventDetailfromModule:
                            pageNotifier.setEventPage(EventPage.main);
                            break;
                          case EventPage.eventDetailfromCalendar:
                            appPageNotifier.setPage(ModuleType.home);
                            pageNotifier.setEventPage(EventPage.main);
                            _hasScrolledNotifier.setHasScrolled(true);
                            break;
                        }
                      },
                      icon: FaIcon(
                        page == EventPage.main
                            ? FontAwesomeIcons.chevronRight
                            : FontAwesomeIcons.chevronLeft,
                        color: Colors.black,
                      ));
                },
              ),
            ),
            const Text(
              EventTextConstants.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
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
