import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/is_admin_provider.dart';
import 'package:myecl/booking/providers/is_manager_provider.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/components/booking_card.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/calendar.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingMainPage extends HookConsumerWidget {
  const BookingMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isManager = ref.watch(isManagerProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final bookingsNotifier = ref.watch(bookingListProvider.notifier);
    final confirmedBookingsNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final confirmedBookings = ref.watch(confirmedBookingListProvider);
    final bookings = ref.watch(bookingListProvider);
    final allBookingsNotifier = ref.watch(bookingListProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    void handleBooking(BookingReturnApplicant booking) {
      bookingNotifier.setBooking(booking);
      final recurrent = booking.recurrenceRule != "";
      if (recurrent) {
        final allDays = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"];
        final recurrentDays = booking.recurrenceRule!
            .split(";")
            .where((element) => element.contains("BYDAY"))
            .first
            .split("=")
            .last
            .split(",");
        selectedDaysNotifier.setSelectedDays(
            allDays.map((e) => recurrentDays.contains(e)).toList());
      }
      QR.to(BookingRouter.root + BookingRouter.addEdit);
    }

    List<Appointment> appointments = <Appointment>[];
    confirmedBookings.whenData((confirmedBookings) {
      confirmedBookings.map((e) {
        if (e.recurrenceRule != "") {
          final dates = getDateInRecurrence(e.recurrenceRule!, e.start);
          dates.map((data) {
            appointments.add(Appointment(
              startTime: combineDate(data, e.start),
              endTime: combineDate(data, e.end),
              subject: '${e.room.name} - ${e.reason}',
              isAllDay: false,
              startTimeZone: "Europe/Paris",
              endTimeZone: "Europe/Paris",
              notes: e.note,
              color: generateColor(e.room.name),
            ));
          }).toList();
        } else {
          appointments.add(Appointment(
            startTime: e.start,
            endTime: e.end,
            subject: '${e.room.name} - ${e.reason}',
            isAllDay: false,
            startTimeZone: "Europe/Paris",
            endTimeZone: "Europe/Paris",
            notes: e.note,
            color: generateColor(e.room.name),
          ));
        }
      }).toList();
    });

    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await confirmedBookingsNotifier.loadConfirmedBooking();
          await bookingsNotifier.loadUserBookings(user.id);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 85,
          child: Column(children: [
            const SizedBox(height: 20),
            Expanded(
                child: Calendar(
                    items: confirmedBookings,
                    dataSource: AppointmentDataSource(appointments))),
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
                            color: Colors.grey)),
                    if (isAdmin)
                      AdminButton(
                        onTap: () {
                          QR.to(BookingRouter.root + BookingRouter.admin);
                        },
                      ),
                    if (isManager)
                      GestureDetector(
                        onTap: () {
                          QR.to(BookingRouter.root + BookingRouter.manager);
                        },
                        child: Container(
                          width: 130,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 1),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5))
                              ]),
                          child: const Row(
                            children: [
                              HeroIcon(HeroIcons.userGroup,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 10),
                              Text("Gestion",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: (isAdmin) ? 15 : 25),
            AsyncChild(
                value: bookings,
                builder: (context, data) {
                  data.sort((a, b) => b.start.compareTo(a.start));
                  return HorizontalListView.builder(
                      height: 180,
                      firstChild: GestureDetector(
                        onTap: () {
                          bookingNotifier
                              .setBooking(BookingReturnApplicant.fromJson({}));
                          selectedDaysNotifier.clear();
                          QR.to(BookingRouter.root + BookingRouter.addEdit);
                        },
                        child: const CardLayout(
                          width: 100,
                          height: 170,
                          child: Center(
                              child: HeroIcon(
                            HeroIcons.plus,
                            size: 40.0,
                            color: Colors.black,
                          )),
                        ),
                      ),
                      items: data,
                      itemBuilder: (context, booking, i) {
                        final e = BookingReturnApplicant(
                          key: booking.key,
                          id: booking.id,
                          start: booking.start,
                          end: booking.end,
                          reason: booking.reason,
                          note: booking.note,
                          recurrenceRule: booking.recurrenceRule,
                          room: booking.room,
                          roomId: booking.roomId,
                          decision: booking.decision,
                          applicantId: booking.applicantId,
                          applicant: Applicant.fromJson({}),
                        );
                        return BookingCard(
                          booking: e,
                          onEdit: () {
                            handleBooking(e);
                          },
                          onInfo: () {
                            bookingNotifier.setBooking(e);
                            QR.to(BookingRouter.root + BookingRouter.detail);
                          },
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
                                                  .deleteBooking(booking);
                                          if (value) {
                                            bookingsNotifier
                                                .deleteBooking(booking);
                                            if (e.decision ==
                                                AppUtilsTypesBookingTypeDecision
                                                    .approved) {
                                              confirmedBookingsNotifier
                                                  .loadConfirmedBooking();
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
                            handleBooking(e.copyWith(id: ""));
                          },
                        );
                      });
                },
                loaderColor: ColorConstants.background2),
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
