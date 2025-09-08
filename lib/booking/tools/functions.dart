import 'package:titan/booking/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

String decisionToString(Decision d) {
  switch (d) {
    case Decision.approved:
      return BookingTextConstants.confirmed;
    case Decision.declined:
      return BookingTextConstants.declined;
    case Decision.pending:
      return BookingTextConstants.pending;
  }
}

String weekDayToString(WeekDays day) {
  switch (day) {
    case WeekDays.sunday:
      return "Dimanche";
    case WeekDays.monday:
      return "Lundi";
    case WeekDays.tuesday:
      return "Mardi";
    case WeekDays.wednesday:
      return "Mercredi";
    case WeekDays.thursday:
      return "Jeudi";
    case WeekDays.friday:
      return "Vendredi";
    case WeekDays.saturday:
      return "Samedi";
  }
}
