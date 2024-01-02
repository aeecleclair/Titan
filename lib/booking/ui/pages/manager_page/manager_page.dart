import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/admin_booking_list_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/booking/ui/components/list_booking.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class ManagerPage extends HookConsumerWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(adminBookingListProvider);
    final List<BookingReturnApplicant> pendingBookings = [],
        confirmedBookings = [],
        canceledBookings = [];
    bookings.maybeWhen(
        data: (
          bookings,
        ) {
          for (BookingReturnApplicant b in bookings) {
            switch (b.decision) {
              case AppUtilsTypesBookingTypeDecision.approved:
                confirmedBookings.add(b);
                break;
              case AppUtilsTypesBookingTypeDecision.declined:
                canceledBookings.add(b);
                break;
              case AppUtilsTypesBookingTypeDecision.pending:
                pendingBookings.add(b);
                break;
              case AppUtilsTypesBookingTypeDecision.swaggerGeneratedUnknown:
                break;
            }
          }
          confirmedBookings.sort((a, b) => b.start.compareTo(a.start));
          canceledBookings.sort((a, b) => b.start.compareTo(a.start));
          pendingBookings.sort((a, b) => b.start.compareTo(a.start));
        },
        orElse: () {});
    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(adminBookingListProvider.notifier).loadBookings();
          await ref.watch(roomListProvider.notifier).loadRooms();
          await ref
              .watch(confirmedBookingListProvider.notifier)
              .loadConfirmedBooking();
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
                height: MediaQuery.of(context).size.height - 380,
                child: const Calendar()),
            const SizedBox(height: 30),
            if (pendingBookings.isEmpty &&
                confirmedBookings.isEmpty &&
                canceledBookings.isEmpty)
              const Center(
                child: Text(BookingTextConstants.noCurrentBooking,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
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
