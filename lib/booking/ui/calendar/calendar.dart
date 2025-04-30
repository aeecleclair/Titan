import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/manager_confirmed_booking_list_provider.dart';
import 'package:myecl/booking/ui/calendar/appointment_data_source.dart';
import 'package:myecl/booking/ui/calendar/calendar_dialog.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends HookConsumerWidget {
  final bool isManagerPage;
  const Calendar({super.key, required this.isManagerPage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = isManagerPage
        ? ref.watch(managerConfirmedBookingListProvider)
        : ref.watch(confirmedBookingListProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);
    final CalendarController calendarController = CalendarController();

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Booking booking = details.appointments![0];
        showDialog(
          context: context,
          builder: (context) => isManagerPage
              ? CalendarDialog(booking: booking, isManager: true)
              : CalendarDialog(booking: booking, isManager: false),
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
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  shape: BoxShape.rectangle,
                ),
                todayHighlightColor: Theme.of(context).colorScheme.secondary,
                todayTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
                firstDayOfWeek: 1,
                timeZone: 'Europe/Paris',
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeIntervalHeight: 25,
                  timeFormat: 'HH:mm',
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  dateTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
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
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        calendarController.forward!();
                      },
                      icon: HeroIcon(
                        HeroIcons.arrowRight,
                        size: 25,
                        color: Theme.of(context).colorScheme.onSecondary,
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
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        calendarController.backward!();
                      },
                      icon: HeroIcon(
                        HeroIcons.arrowLeft,
                        size: 25,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        );
      },
    );
  }
}
