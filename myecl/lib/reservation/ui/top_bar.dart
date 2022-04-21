import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/reservation/providers/reservation_page_provider.dart';
import 'package:myecl/reservation/tools/functions.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(reservationPageProvider);
    return Column(
      children: [
        const SizedBox(
          height: 20,
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
                        if (page == 0) {
                          controllerNotifier.toggle();
                        } else {
                          ref
                              .watch(reservationPageProvider.notifier)
                              .setReservationPage(0);
                        }
                      },
                      icon: FaIcon(
                        page == 0
                            ? FontAwesomeIcons.chevronRight
                            : FontAwesomeIcons.chevronLeft,
                        color: Colors.grey.shade100,
                      ));
                },
              ),
            ),
            Text(
              getPageTitle(page),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade100,
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
