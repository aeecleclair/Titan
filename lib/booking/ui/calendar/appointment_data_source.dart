import 'dart:ui';

import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource<BookingReturn> {
  AppointmentDataSource(List<BookingReturnSimpleApplicant> source) {
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
    BookingReturn bookingReturn = appointments![index];
    return '${bookingReturn.room.name} - ${bookingReturn.reason}';
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
    BookingReturn bookingReturn = appointments![index];
    return (bookingReturn.recurrenceRule ?? "").isNotEmpty
        ? bookingReturn.recurrenceRule
        : null;
  }

  @override
  BookingReturn? convertAppointmentToObject(
    BookingReturn customData,
    Appointment appointment,
  ) =>
      customData;
}
