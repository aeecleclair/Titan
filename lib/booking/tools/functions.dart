import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

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
    default:
      return BookingTextConstants.pending;
  }
}

DateTime getTrueEnd(Booking b) {
  if (b.recurrenceRule.isEmpty) {
    return b.end;
  } else {
    final days = b.recurrenceRule.split("BYDAY=")[1].split(";")[0].split(",");
    if (days.length > 1) {
      final date = getDateInRecurrence(b.recurrenceRule, b.start).last;
      return DateTime(
          date.year, date.month, date.day, b.end.hour, b.end.minute);
    }
    return b.end;
  }
}
