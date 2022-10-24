import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/pages/main_page/booking_card.dart';
import 'package:myecl/booking/ui/refresh_indicator.dart';
import 'package:myecl/booking/ui/pages/main_page/calendar.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = !ref.watch(isBookingAdmin); //! A changer
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final bookings = ref.watch(userBookingListProvider);
    return BookingRefresher(
      onRefresh: () async {
        await bookingsNotifier.loadUserBookings();
      },
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(BookingTextConstants.booking,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: MediaQuery.of(context).size.height - 460,
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
                        color: Color.fromARGB(255, 205, 205, 205))),
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
        bookings.when(
            data: (List<Booking> data) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          pageNotifier.setBookingPage(BookingPage.addBooking);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 120,
                            height: 180,
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
                      ...data.map((e) => BookingCard(
                            booking: e,
                            onEdit: () {},
                            onReturn: () {},
                          )),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
            error: (Object error, StackTrace? stackTrace) {
              return Center(child: Text("Error $error"));
            },
            loading: () {
              return const Center(
                  child: CircularProgressIndicator(
                color: BookingColorConstants.darkBlue,
              ));
            })

        // const Button(
        //   text: BookingTextConstants.addBookingPage,
        //   page: BookingPage.addBooking,
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // const Button(
        //   text: BookingTextConstants.myBookings,
        //   page: BookingPage.bookings,
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // isAdmin
        //     ? Column(
        //         children: const [
        //           Button(
        //             text: BookingTextConstants.adminPage,
        //             page: BookingPage.admin,
        //           ),
        //           SizedBox(
        //             height: 20,
        //           ),
        //         ],
        //       )
        //     : Container(),
      ]),
    );
  }
}
