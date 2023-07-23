import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/components/booking_card.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/admin_button.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class BookingMainPage extends HookConsumerWidget {
  const BookingMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isBookingAdminProvider);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final confirmedBookingsNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final bookings = ref.watch(userBookingListProvider);
    final allBookingsNotifier = ref.watch(bookingListProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await confirmedBookingsNotifier.loadConfirmedBooking();
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
                      AdminButton(
                        onTap: () {
                          QR.to(BookingRouter.root + BookingRouter.admin);
                        },
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: (isAdmin) ? 0 : 10,
            ),
            bookings.when(
              data: (List<Booking> data) {
                data.sort((a, b) => b.start.compareTo(a.start));
                return SizedBox(
                    height: 210,
                    child: HorizontalListView(
                        child: Row(children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () {
                            bookingNotifier.setBooking(Booking.empty());
                            selectedDaysNotifier.clear();
                            QR.to(BookingRouter.root + BookingRouter.addEdit);
                          },
                          child: const CardLayout(
                            width: 120,
                            height: 200,
                            child: Center(
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
                                    .where(
                                        (element) => element.contains("BYDAY"))
                                    .first
                                    .split("=")
                                    .last
                                    .split(",");
                                selectedDaysNotifier.setSelectedDays(allDays
                                    .map((e) => recurrentDays.contains(e))
                                    .toList());
                              }
                              QR.to(BookingRouter.root + BookingRouter.addEdit);
                            },
                            onInfo: () {
                              bookingNotifier.setBooking(e);
                              QR.to(BookingRouter.root + BookingRouter.detail);
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
                                                confirmedBookingsNotifier
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
                                          title: BookingTextConstants
                                              .deleteBooking,
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
                                    .where(
                                        (element) => element.contains("BYDAY"))
                                    .first
                                    .split("=")
                                    .last
                                    .split(",");
                                selectedDaysNotifier.setSelectedDays(allDays
                                    .map((e) => recurrentDays.contains(e))
                                    .toList());
                              }
                              QR.to(BookingRouter.root + BookingRouter.addEdit);
                            },
                          )),
                      const SizedBox(width: 15)
                    ])));
              },
              loading: () => const Loader(color: ColorConstants.background2),
              error: (Object error, StackTrace? stackTrace) =>
                  Center(child: Text("Error $error")),
            )
          ]),
        ),
      ),
    );
  }
}
