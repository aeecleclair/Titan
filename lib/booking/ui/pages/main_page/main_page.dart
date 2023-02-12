import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking_card.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isBookingAdminProvider);
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final confirmedbookingsNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final bookings = ref.watch(userBookingListProvider);
    final allBookingsNotifier = ref.watch(bookingListProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return Refresher(
      onRefresh: () async {
        await confirmedbookingsNotifier.loadConfirmedBooking();
        await bookingsNotifier.loadUserBookings();
      },
      child: Column(children: [
        const SizedBox(height: 20),
        SizedBox(
            height: MediaQuery.of(context).size.height - 375,
            child: const Calendar()),
        SizedBox(
          height: (isAdmin) ? 25 : 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(BookingTextConstants.myBookings,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149))),
                if (isAdmin)
                  GestureDetector(
                    onTap: () {
                      pageNotifier.setBookingPage(BookingPage.admin);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ]),
                      child: Row(
                        children: const [
                          HeroIcon(HeroIcons.userGroup,
                              color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text("Admin",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        SizedBox(
          height: (isAdmin) ? 0 : 10,
        ),
        SizedBox(
          height: 200,
          child: bookings.when(data: (List<Booking> data) {
            data.sort((a, b) => a.start.compareTo(b.start));
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: () {
                        bookingNotifier.setBooking(Booking.empty());
                        pageNotifier.setBookingPage(BookingPage.addEditBooking);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                              child: HeroIcon(
                            HeroIcons.plus,
                            size: 40.0,
                            color: Colors.black,
                          )),
                        ),
                      ),
                    ),
                  );
                } else if (index == data.length + 1) {
                  return const SizedBox(width: 15);
                } else {
                  final e = data[index - 1];
                  return BookingCard(
                    booking: e,
                    isAdmin: false,
                    isDetail: false,
                    onEdit: () {
                      bookingNotifier.setBooking(e);
                      pageNotifier.setBookingPage(BookingPage.addEditBooking);
                    },
                    onInfo: () {
                      bookingNotifier.setBooking(e);
                      pageNotifier
                          .setBookingPage(BookingPage.detailBookingFromMain);
                    },
                    onConfirm: () {},
                    onDecline: () {},
                    onDelete: () async {
                      await tokenExpireWrapper(ref, () async {
                        await showDialog(
                            context: context,
                            builder: (context) => CustomDialogBox(
                                  descriptions: BookingTextConstants
                                      .deleteBookingConfirmation,
                                  onYes: () async {
                                    final value = await allBookingsNotifier
                                        .deleteBooking(e);
                                    if (value) {
                                      confirmedbookingsNotifier
                                          .deleteBooking(e);
                                      displayToastWithContext(TypeMsg.msg,
                                          BookingTextConstants.deleteBooking);
                                    } else {
                                      displayToastWithContext(TypeMsg.error,
                                          BookingTextConstants.deletingError);
                                    }
                                  },
                                  title: BookingTextConstants.deleteBooking,
                                ));
                      });
                    },
                    onCopy: () {
                      bookingNotifier.setBooking(e.copyWith(id: ""));
                      pageNotifier.setBookingPage(BookingPage.addEditBooking);
                    },
                  );
                }
              },
            );
          }, error: (Object error, StackTrace? stackTrace) {
            return Center(child: Text("Error $error"));
          }, loading: () {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorConstants.background2,
            ));
          }),
        )
      ]),
    );
  }
}
