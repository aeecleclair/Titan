import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/booking/ui/components/waiter.dart';
import 'package:myecl/booking/ui/pages/admin_page/list_booking.dart';
import 'package:myecl/booking/ui/components/room_chip.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomList = ref.watch(roomListProvider);
    final room = ref.watch(roomProvider);
    final roomNotifier = ref.watch(roomProvider.notifier);
    final bookings = ref.watch(bookingListProvider);
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
          confirmedBookings.sort((a, b) => b.start.compareTo(a.start));
          canceledBookings.sort((a, b) => b.start.compareTo(a.start));
          pendingBookings.sort((a, b) => b.start.compareTo(a.start));
        },
        error: (e, s) {},
        loading: () {});
    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(bookingListProvider.notifier).loadBookings();
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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(BookingTextConstants.room,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149))),
              ),
            ),
            const SizedBox(height: 30),
            roomList.when(
              data: (List<Room> data) => HorizontalListView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        roomNotifier.setRoom(Room.empty());
                        QR.to(BookingRouter.root +
                            BookingRouter.admin +
                            BookingRouter.room);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Chip(
                            label: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: HeroIcon(
                                HeroIcons.plus,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          )),
                    ),
                    ...data.map(
                      (e) => RoomChip(
                        label: capitalize(e.name),
                        selected: room.id == e.id,
                        onTap: () {
                          roomNotifier.setRoom(e);
                          QR.to(BookingRouter.root +
                              BookingRouter.admin +
                              BookingRouter.room);
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              error: (Object error, StackTrace? stackTrace) {
                return Center(child: Text('Error $error'));
              },
              loading: () {
                return const Waiter();
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
