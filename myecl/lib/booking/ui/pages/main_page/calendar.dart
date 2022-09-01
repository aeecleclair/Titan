import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingListProvider);
    CalendarController _controller = CalendarController();

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Appointment appointmentDetails = details.appointments![0];
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(appointmentDetails.subject),
                  content: SizedBox(
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          processDateWithHour(appointmentDetails.startTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          processDateWithHour(appointmentDetails.endTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(appointmentDetails.notes ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                  ));
            });
      }
    }

    return SizedBox(
      height: 360,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: BookingColorConstants.softBlack,
              offset: const Offset(2, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: bookings.when(data: (res) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: [
                SfCalendar(
                  onTap: (details) => calendarTapped(details, context),
                  dataSource: _getCalendarDataSource(res),
                  appointmentBuilder: (BuildContext context,
                      CalendarAppointmentDetails details) {
                    final Appointment meeting = details.appointments.first;
                    if (_controller.view != CalendarView.month &&
                        _controller.view != CalendarView.schedule &&
                        meeting.startTime.day == meeting.endTime.day) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 50,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              color: meeting.color,
                            ),
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meeting.subject,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 3,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                          ),
                          Container(
                            height: details.bounds.height - 70,
                            padding: const EdgeInsets.fromLTRB(3, 5, 3, 2),
                            color: meeting.color.withOpacity(0.8),
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meeting.notes!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            )),
                          ),
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: meeting.color,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.all(3),
                      height: 50,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: meeting.color,
                      ),
                      child: Text(
                            meeting.subject,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  },
                  view: CalendarView.week,
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: BookingColorConstants.darkBlue, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    shape: BoxShape.rectangle,
                  ),
                  todayHighlightColor: BookingColorConstants.lightBlue,
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
                      color: BookingColorConstants.darkBlue,
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
              color: BookingColorConstants.darkBlue,
            ),
          );
        }),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource(List<Booking> res) {
  List<Appointment> appointments = <Appointment>[];
  res.where((e) => e.decision == Decision.approved).map((e) {
    RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
    recurrence.weekDays = WeekDays.values;
    recurrence.interval = 7;
    appointments.add(Appointment(
        startTime: e.start,
        endTime: e.end,
        subject: e.room.name + ' - ' + e.reason,
        isAllDay: false,
        startTimeZone: "Europe/Paris",
        endTimeZone: "Europe/Paris",
        notes: e.note,
        recurrenceRule: e.recurring
            ? SfCalendar.generateRRule(recurrence, e.start, e.end)
            : ""));
  }).toList();
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
