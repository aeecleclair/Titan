import 'dart:ui';

import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource<Booking> {
  AppointmentDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].start as DateTime;

  @override
  DateTime getEndTime(int index) => appointments![index].end as DateTime;

  @override
  Color getColor(int index) =>
      generateColor(appointments![index].room.name as String);

  @override
  String getSubject(int index) {
    Booking booking = appointments![index] as Booking;
    return '${booking.room.name} - ${booking.reason}';
  }

  @override
  bool isAllDay(int index) => false;

  @override
  String? getNotes(int index) => appointments![index].note as String;

  @override
  String? getStartTimeZone(int index) => "Europe/Paris";

  @override
  String? getEndTimeZone(int index) => "Europe/Paris";

  @override
  String? getRecurrenceRule(int index) {
    Booking booking = appointments![index] as Booking;
    return booking.recurrenceRule.isNotEmpty ? booking.recurrenceRule : null;
  }

  @override
  Booking? convertAppointmentToObject(
          Booking customData, Appointment appointment) =>
      customData;
}
