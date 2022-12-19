import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/pages/admin_page/room_chip.dart';
import 'package:myecl/booking/ui/booking_card.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final roomList = ref.watch(roomListProvider);
    final room = ref.watch(roomProvider);
    final roomNotifier = ref.watch(roomProvider.notifier);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
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
        },
        error: (e, s) {},
        loading: () {});
    return Expanded(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(bookingListProvider.notifier).loadBookings();
        },
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(BookingTextConstants.room,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 205, 205, 205))),
              ),
            ),
            const SizedBox(height: 10),
            roomList.when(
              data: (List<Room> data) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        roomNotifier.setRoom(Room.empty());
                        pageNotifier.setBookingPage(BookingPage.addEditRoom);
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
                          pageNotifier.setBookingPage(BookingPage.addEditRoom);
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
                return const Center(child: CircularProgressIndicator());
              },
            ),
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
            if (pendingBookings.isNotEmpty)
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(BookingTextConstants.pending,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205))),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ...pendingBookings.map((e) => BookingCard(
                              booking: e,
                              isAdmin: true,
                              isDetail: false,
                              onEdit: () {
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
                              onReturn: () {
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
                              onInfo: () {
                                bookingNotifier.setBooking(e);
                                pageNotifier.setBookingPage(
                                    BookingPage.detailBookingFromAdmin);
                              },
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            if (confirmedBookings.isNotEmpty)
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(BookingTextConstants.confirmed,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205))),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ...confirmedBookings.map((e) => BookingCard(
                              booking: e,
                              isAdmin: true,
                              isDetail: false,
                              onEdit: () {},
                              onReturn: () {
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
                              onInfo: () {
                                bookingNotifier.setBooking(e);
                                pageNotifier.setBookingPage(
                                    BookingPage.detailBookingFromAdmin);
                              },
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            if (canceledBookings.isNotEmpty)
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(BookingTextConstants.declined,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205))),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ...canceledBookings.map((e) => BookingCard(
                              booking: e,
                              isAdmin: true,
                              isDetail: false,
                              onEdit: () {
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
                              onReturn: () {},
                              onInfo: () {
                                bookingNotifier.setBooking(e);
                                pageNotifier.setBookingPage(
                                    BookingPage.detailBookingFromAdmin);
                              },
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              )
          ],
        ),
      ),
    );
  }
}
