import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking_ui.dart';

class ListBooking extends ConsumerWidget {
  final bool isAdmin;
  const ListBooking({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = isAdmin
        ? ref.watch(bookingListProvider)
        : ref.watch(userBookingListProvider);
    final List<Booking> pendingBookings = [],
        confirmedBookings = [],
        canceledBookings = [];
    bookings.when(
        data: (
          bookings,
        ) {
          for (Booking b in bookings) {
            switch (b.decision) {
              case Decision.approved:
                confirmedBookings.add(b);
                break;
              case Decision.declined:
                canceledBookings.add(b);
                break;
              case Decision.pending:
                pendingBookings.add(b);
                break;
            }
          }
        },
        error: (e, s) {},
        loading: () {});
    return Column(
      children: [
        if (pendingBookings.isEmpty &&
            confirmedBookings.isEmpty &&
            canceledBookings.isEmpty)
          const Center(
            child: Text(BookingTextConstants.noCurrentBooking,
                style: TextStyle(
                    color: BookingColorConstants.darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        if (pendingBookings.isNotEmpty)
          Column(children: [
            const Text(BookingTextConstants.pending,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: BookingColorConstants.darkBlue)),
            const SizedBox(
              height: 10,
            ),
            ...pendingBookings.map((x) => BookingUi(
                  booking: x,
                  isAdmin: isAdmin,
                ))
          ]),
        if (confirmedBookings.isNotEmpty)
          Column(children: [
            const Text(BookingTextConstants.confirmed,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: BookingColorConstants.darkBlue)),
            const SizedBox(
              height: 10,
            ),
            ...confirmedBookings.map((x) => BookingUi(
                  booking: x,
                  isAdmin: isAdmin,
                ))
          ]),
        if (canceledBookings.isNotEmpty)
          Column(children: [
            const Text(BookingTextConstants.declined,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: BookingColorConstants.darkBlue)),
            const SizedBox(
              height: 10,
            ),
            ...canceledBookings.map((x) => BookingUi(
                  booking: x,
                  isAdmin: isAdmin,
                ))
          ])
      ],
    );
  }
}
