import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/booking_provider.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/booking/providers/manager_confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/selected_days_provider.dart';
import 'package:titan/booking/providers/user_booking_list_provider.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/booking/ui/calendar/appointment_data_source.dart';
import 'package:titan/booking/ui/calendar/calendar_dialog.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class Calendar extends HookConsumerWidget {
  final bool isManagerPage;
  const Calendar({super.key, required this.isManagerPage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = isManagerPage
        ? ref.watch(managerConfirmedBookingListProvider)
        : ref.watch(confirmedBookingListProvider);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);
    final bookingListNotifier = ref.watch(managerBookingListProvider.notifier);
    final confirmedBookingListNotifier = ref.watch(
      confirmedBookingListProvider.notifier,
    );
    final isWebFormat = ref.watch(isWebFormatProvider);
    final managerConfirmedBookingListNotifier = ref.watch(
      managerConfirmedBookingListProvider.notifier,
    );
    final CalendarController calendarController = CalendarController();

    void handleBooking(Booking booking) {
      bookingNotifier.setBooking(booking);
      final recurrentDays = SfCalendar.parseRRule(
        booking.recurrenceRule,
        booking.start,
      ).weekDays;
      selectedDaysNotifier.setSelectedDays(recurrentDays);
      QR.to(BookingRouter.root + BookingRouter.manager + BookingRouter.addEdit);
    }

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Booking booking = details.appointments![0];
        showDialog(
          context: context,
          builder: (context) => CalendarDialog(
            booking: booking,
            isManager: isManagerPage,
            onEdit: () {
              handleBooking(booking);
            },
            onCopy: () {
              handleBooking(booking.copyWith(id: ""));
            },
            onConfirm: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    title: BookingTextConstants.confirm,
                    descriptions: BookingTextConstants.confirmBooking,
                    onYes: () async {
                      await tokenExpireWrapper(ref, () async {
                        Booking newBooking = booking.copyWith(
                          decision: Decision.approved,
                        );
                        bookingListNotifier
                            .toggleConfirmed(newBooking, Decision.approved)
                            .then((value) {
                              if (value) {
                                ref
                                    .read(userBookingListProvider.notifier)
                                    .loadUserBookings();
                                confirmedBookingListNotifier.addBooking(
                                  newBooking,
                                );
                                managerConfirmedBookingListNotifier.addBooking(
                                  newBooking,
                                );
                              }
                            });
                      });
                    },
                  );
                },
              );
            },
            onDecline: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    title: BookingTextConstants.decline,
                    descriptions: BookingTextConstants.declineBooking,
                    onYes: () async {
                      await tokenExpireWrapper(ref, () async {
                        Booking newBooking = booking.copyWith(
                          decision: Decision.declined,
                        );
                        bookingListNotifier
                            .toggleConfirmed(newBooking, Decision.declined)
                            .then((value) {
                              if (value) {
                                ref
                                    .read(userBookingListProvider.notifier)
                                    .loadUserBookings();
                                confirmedBookingListNotifier.deleteBooking(
                                  newBooking,
                                );
                                managerConfirmedBookingListNotifier
                                    .deleteBooking(newBooking);
                              }
                            });
                      });
                    },
                  );
                },
              );
            },
          ),
        );
      }
    }

    return bookings.when(
      data: (res) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              SfCalendar(
                onTap: (details) => calendarTapped(details, context),
                dataSource: AppointmentDataSource(res),
                controller: calendarController,
                view: CalendarView.week,
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  shape: BoxShape.rectangle,
                ),
                todayHighlightColor: Colors.black,
                todayTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                firstDayOfWeek: 1,
                timeZone: 'Europe/Paris',
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeIntervalHeight: 25,
                  timeFormat: 'HH:mm',
                ),
                viewHeaderStyle: const ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  dateTextStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                headerStyle: const CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              if (isWebFormat)
                Positioned(
                  right: 30,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700.withValues(alpha: 0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        calendarController.forward!();
                      },
                      icon: const HeroIcon(
                        HeroIcons.arrowRight,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (isWebFormat)
                Positioned(
                  left: 30,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700.withValues(alpha: 0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        calendarController.backward!();
                      },
                      icon: const HeroIcon(
                        HeroIcons.arrowLeft,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(color: ColorConstants.background2),
        );
      },
    );
  }
}
