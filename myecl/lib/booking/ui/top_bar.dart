import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/tools/functions.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bookingPageProvider);
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
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
                          case BookingPage.main:
                              controllerNotifier.toggle();
                            break;
                          case BookingPage.admin:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.addBooking:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.info:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.bookings:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.rooms:
                            pageNotifier.setBookingPage(BookingPage.admin);
                            break;
                          case BookingPage.addRoom:
                            pageNotifier.setBookingPage(BookingPage.rooms);
                            break;
                          case BookingPage.editRoom:
                            pageNotifier.setBookingPage(BookingPage.rooms);
                            break;
                          case BookingPage.editBooking:
                            pageNotifier.setBookingPage(BookingPage.bookings);
                            break;
                        }
                      },
                      icon: FaIcon(
                        page == BookingPage.main
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
