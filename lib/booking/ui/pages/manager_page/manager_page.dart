import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/booking/providers/manager_confirmed_booking_list_provider.dart';
import 'package:titan/service/providers/room_list_provider.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/booking/ui/booking.dart';
import 'package:titan/booking/ui/calendar/calendar.dart';
import 'package:titan/booking/ui/pages/manager_page/list_booking.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class ManagerPage extends HookConsumerWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(managerBookingListProvider);
    final List<Booking> pendingBookings = [],
        confirmedBookings = [],
        canceledBookings = [];
    bookings.maybeWhen(
      data: (bookings) {
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
        confirmedBookings.sort((a, b) => b.creation.compareTo(a.creation));
        canceledBookings.sort((a, b) => b.creation.compareTo(a.creation));
        pendingBookings.sort((a, b) => b.creation.compareTo(a.creation));
      },
      orElse: () {},
    );
    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await ref
              .watch(managerBookingListProvider.notifier)
              .loadUserManageBookings();
          await ref.watch(roomListProvider.notifier).loadRooms();
          await ref
              .watch(managerConfirmedBookingListProvider.notifier)
              .loadConfirmedBookingForManager();
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height - 380,
              child: const Calendar(isManagerPage: true),
            ),
            const SizedBox(height: 30),
            if (pendingBookings.isEmpty &&
                confirmedBookings.isEmpty &&
                canceledBookings.isEmpty)
              const Center(
                child: Text(
                  BookingTextConstants.noCurrentBooking,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ListBooking(
              title: BookingTextConstants.pending,
              bookings: pendingBookings,
              canToggle: false,
            ),
            ListBooking(
              title: BookingTextConstants.confirmed,
              bookings: confirmedBookings,
            ),
            ListBooking(
              title: BookingTextConstants.declined,
              bookings: canceledBookings,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
