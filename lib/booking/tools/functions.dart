import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Decision stringToDecision(String s) {
  switch (s) {
    case "approved":
      return Decision.approved;
    case "declined":
      return Decision.declined;
    case "pending":
      return Decision.pending;
    default:
      return Decision.pending;
  }
}

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
