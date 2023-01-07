import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking_card.dart';
import 'package:myecl/tools/dialog.dart';

class ListBooking extends HookConsumerWidget {
  final List<Booking> bookings;
  final bool canToggle = true;
  final String title;
  const ListBooking({
    Key? key,
    required this.bookings,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    final toggle = useState(false);
    if (bookings.isNotEmpty) {
      return Column(
        children: [
          if (canToggle)
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  toggle.value = !toggle.value;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 205, 205, 205))),
                      ),
                      HeroIcon(
                        toggle.value
                            ? HeroIcons.chevronUp
                            : HeroIcons.chevronDown,
                        color: const Color.fromARGB(255, 205, 205, 205),
                        size: 30,
                      ),
                    ],
                  ),
                )),
          if (toggle.value)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  ...bookings.map((e) => BookingCard(
                        booking: e,
                        isAdmin: true,
                        isDetail: false,
                        onEdit: () {
                          bookingNotifier.setBooking(e);
                          pageNotifier.setBookingPage(
                              BookingPage.addEditBookingFromAdmin);
                        },
                        onInfo: () {
                          bookingNotifier.setBooking(e);
                          pageNotifier.setBookingPage(
                              BookingPage.detailBookingFromAdmin);
                        },
                        onConfirm: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                    title: BookingTextConstants.confirm,
                                    descriptions:
                                        BookingTextConstants.confirmBooking,
                                    onYes: () async {
                                      bookingListNotifier.toggleConfirmed(
                                          e, Decision.approved);
                                    });
                              });
                        },
                        onDecline: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                    title: BookingTextConstants.decline,
                                    descriptions:
                                        BookingTextConstants.declineBooking,
                                    onYes: () async {
                                      bookingListNotifier.toggleConfirmed(
                                          e, Decision.declined);
                                    });
                              });
                        },
                        onCopy: () {
                          bookingNotifier.setBooking(e.copyWith(id: ""));
                          pageNotifier.setBookingPage(
                              BookingPage.addEditBookingFromAdmin);
                        },
                      )),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          const SizedBox(height: 30),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
