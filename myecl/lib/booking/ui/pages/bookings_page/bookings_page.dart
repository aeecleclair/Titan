import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              pendingBookings.isEmpty
                  ? Container()
                  : Column(children: [
                      const Text("En attente",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      ...pendingBookings.map((x) => BookingUi(
                            booking: x,
                            isAdmin: false,
                          ))
                    ]),
              confirmedBookings.isEmpty
                  ? Container()
                  : Column(children: [
                      const Text("Confirmés",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      ...confirmedBookings.map((x) => BookingUi(
                            booking: x,
                            isAdmin: false,
                          ))
                    ]),
              canceledBookings.isEmpty
                  ? Container()
                  : Column(children: [
                      const Text("Réfusés",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      ...canceledBookings.map((x) => BookingUi(
                            booking: x,
                            isAdmin: false,
                          ))
                    ])
            ],
          ),
        ),
      ),
    );
  }
}
