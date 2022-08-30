import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/ui/booking_list.dart';
import 'package:myecl/booking/ui/booking_ui.dart';
import 'package:myecl/booking/ui/refresh_indicator.dart';

class BookingsPage extends HookConsumerWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBookings = ref.watch(bookingListProvider);
    final List<Booking> pendingBookings = [],
        confirmedBookings = [],
        canceledBookings = [];
    userBookings.when(
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
    return SizedBox(
      height: MediaQuery.of(context).size.height - 110,
      child: BookingRefresher(
        onRefresh: () async {},
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: ListBooking(isAdmin: false,)
        ),
      ),
    );
  }
}
