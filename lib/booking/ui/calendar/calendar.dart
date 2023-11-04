import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/user_manager_list_provider.dart';
import 'package:myecl/booking/ui/calendar/appointment_data_source.dart';
import 'package:myecl/booking/ui/calendar/calendar_dialog.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(confirmedBookingListProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);
    final userManagers = ref.watch(userManagerListProvider);
    final CalendarController calendarController = CalendarController();

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Booking booking = details.appointments![0];
        showDialog(
          context: context,
          builder: (context) => userManagers.when(
            data: (managers) => managers
                    .map((manager) => manager.id)
                    .contains(booking.room.managerId)
                ? CalendarDialog(booking: booking, isManager: true)
                : CalendarDialog(booking: booking, isManager: false),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.background2,
              ),
            ),
            error: (Object error, StackTrace stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            },
          ),
        );
      }
    }

    return bookings.when(data: (res) {
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
                  color: Colors.white, fontWeight: FontWeight.bold),
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
                  )),
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
                            color: Colors.grey.shade700.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ]),
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
                            color: Colors.grey.shade700.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ]),
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
    }, error: (Object error, StackTrace? stackTrace) {
      return Center(
        child: Text(error.toString()),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorConstants.background2,
        ),
      );
    });
  }
}
