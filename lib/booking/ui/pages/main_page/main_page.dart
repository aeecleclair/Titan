import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking_card.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/web_list_view.dart';

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
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return Expanded(
      child: Refresher(
        onRefresh: () async {
          await confirmedbookingsNotifier.loadConfirmedBooking();
          await bookingsNotifier.loadUserBookings();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 85,
          child: Column(children: [
            const SizedBox(height: 20),
            const Expanded(child: Calendar()),
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
            bookings.when(data: (List<Booking> data) {
              data.sort((a, b) => a.start.compareTo(b.start));
              return SizedBox(
                  height: 210,
                  child: WebListView(
                      child: Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          bookingNotifier.setBooking(Booking.empty());
                          selectedDaysNotifier.clear();
                          pageNotifier
                              .setBookingPage(BookingPage.addEditBooking);
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
                    ),
                    ...data.map((e) => BookingCard(
                          booking: e,
                          isAdmin: false,
                          isDetail: false,
                          onEdit: () {
                            bookingNotifier.setBooking(e);
                            final recurrent = e.recurrenceRule != "";
                            if (recurrent) {
                              final allDays = [
                                "MO",
                                "TU",
                                "WE",
                                "TH",
                                "FR",
                                "SA",
                                "SU"
                              ];
                              final recurrentDays = e.recurrenceRule
                                  .split(";")
                                  .where((element) => element.contains("BYDAY"))
                                  .first
                                  .split("=")
                                  .last
                                  .split(",");
                              selectedDaysNotifier.setSelectedDays(allDays
                                  .map((e) => recurrentDays.contains(e))
                                  .toList());
                            }
                            pageNotifier
                                .setBookingPage(BookingPage.addEditBooking);
                          },
                          onInfo: () {
                            bookingNotifier.setBooking(e);
                            pageNotifier.setBookingPage(
                                BookingPage.detailBookingFromMain);
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
                                          final value =
                                              await allBookingsNotifier
                                                  .deleteBooking(e);
                                          if (value) {
                                            bookingsNotifier.deleteBooking(e);
                                            if (e.decision ==
                                                Decision.approved) {
                                              confirmedbookingsNotifier
                                                  .deleteBooking(e);
                                            }

                                            displayToastWithContext(
                                                TypeMsg.msg,
                                                BookingTextConstants
                                                    .deleteBooking);
                                          } else {
                                            displayToastWithContext(
                                                TypeMsg.error,
                                                BookingTextConstants
                                                    .deletingError);
                                          }
                                        },
                                        title:
                                            BookingTextConstants.deleteBooking,
                                      ));
                            });
                          },
                          onCopy: () {
                            bookingNotifier.setBooking(e.copyWith(id: ""));
                            final recurrent = e.recurrenceRule != "";
                            if (recurrent) {
                              final allDays = [
                                "MO",
                                "TU",
                                "WE",
                                "TH",
                                "FR",
                                "SA",
                                "SU"
                              ];
                              final recurrentDays = e.recurrenceRule
                                  .split(";")
                                  .where((element) => element.contains("BYDAY"))
                                  .first
                                  .split("=")
                                  .last
                                  .split(",");
                              selectedDaysNotifier.setSelectedDays(allDays
                                  .map((e) => recurrentDays.contains(e))
                                  .toList());
                            }
                            pageNotifier
                                .setBookingPage(BookingPage.addEditBooking);
                          },
                        )),
                    const SizedBox(width: 15)
                  ])));
            }, error: (Object error, StackTrace? stackTrace) {
              return Center(child: Text("Error $error"));
            }, loading: () {
              return const Center(
                  child: CircularProgressIndicator(
                color: ColorConstants.background2,
              ));
            }),
          ]),
        ),
      ),
    );
  }
}
