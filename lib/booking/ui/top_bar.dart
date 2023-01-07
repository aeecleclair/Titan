import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';

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
                          case BookingPage.main:
                            controllerNotifier.toggle();
                            break;
                          case BookingPage.admin:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.addEditBooking:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.addEditRoom:
                            pageNotifier.setBookingPage(BookingPage.admin);
                            break;
                          case BookingPage.detailBookingFromAdmin:
                            pageNotifier.setBookingPage(BookingPage.admin);
                            break;
                          case BookingPage.detailBookingFromMain:
                            pageNotifier.setBookingPage(BookingPage.main);
                            break;
                          case BookingPage.addEditBookingFromAdmin:
                            pageNotifier.setBookingPage(BookingPage.admin);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == BookingPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(BookingTextConstants.booking,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
