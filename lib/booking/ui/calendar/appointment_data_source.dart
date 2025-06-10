import 'dart:ui';

import 'package:titan/booking/class/booking.dart';
import 'package:titan/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource<Booking> {
  AppointmentDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].start;

  @override
  DateTime getEndTime(int index) => appointments![index].end;

  @override
  Color getColor(int index) => generateColor(appointments![index].room.name);

  @override
  String getSubject(int index) {
    Booking booking = appointments![index];
    return '${booking.room.name} - ${booking.reason}';
  }

  @override
  bool isAllDay(int index) => false;

  @override
  String? getNotes(int index) => appointments![index].note;

  @override
  String? getStartTimeZone(int index) => "Europe/Paris";

  @override
  String? getEndTimeZone(int index) => "Europe/Paris";

  @override
  String? getRecurrenceRule(int index) {
    Booking booking = appointments![index];
    return booking.recurrenceRule.isNotEmpty ? booking.recurrenceRule : null;
  }

  @override
  Booking? convertAppointmentToObject(
    Booking customData,
    Appointment appointment,
  ) => customData;
}
