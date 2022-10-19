import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/booking/ui/page_switcher.dart';
import 'package:myecl/booking/ui/top_bar.dart';

class BookingHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const BookingHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bookingPageProvider);
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case BookingPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
          case BookingPage.admin:
            pageNotifier.setBookingPage(BookingPage.main);
            break;
          case BookingPage.addBooking:
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
        return false;
      },
      child: Container(
        color: Colors.white,
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
      ),
    ));
  }
}
