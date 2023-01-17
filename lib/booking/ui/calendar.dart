import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/tools/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(confirmedBookingListProvider);

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Appointment appointmentDetails = details.appointments![0];
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 220 +
                            (appointmentDetails.notes!.length / 30 - 5) * 15,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(appointmentDetails.subject,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const SizedBox(height: 10),
                            Text(
                              formatDates(
                                  appointmentDetails.startTime,
                                  appointmentDetails.endTime,
                                  appointmentDetails.isAllDay),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(appointmentDetails.notes ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15)),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -10,
                          right: -10,
                          child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade500
                                                .withOpacity(0.3),
                                            blurRadius: 5,
                                            spreadRadius: 1)
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const HeroIcon(
                                    HeroIcons.xMark,
                                    size: 20,
                                  ))))
                    ],
                  ));
            });
      }
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: bookings.when(data: (res) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: [
                SfCalendar(
                  onTap: (details) => calendarTapped(details, context),
                  dataSource: _getCalendarDataSource(res),
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
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                )
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
        }),
      );
    });
  }
}

_AppointmentDataSource _getCalendarDataSource(List<Booking> res) {
  List<Appointment> appointments = <Appointment>[];
  res.map((e) {
    appointments.add(Appointment(
        startTime: e.start,
        endTime: e.end,
        subject: '${e.room.name} - ${e.reason}',
        isAllDay: false,
        startTimeZone: "Europe/Paris",
        endTimeZone: "Europe/Paris",
        notes: e.note,
        color: generateColor(e.room.id),
        recurrenceRule: e.recurrenceRule));
  }).toList();
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
