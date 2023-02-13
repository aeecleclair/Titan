import 'package:flutter/material.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
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
    default:
      return BookingTextConstants.pending;
  }
}

String formatDates(DateTime dateStart, DateTime dateEnd, bool allDay) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  if (start[0] == end[0]) {
    return "Le ${start[0].substring(0, start[0].length - 5)} ${allDay ? "toute la journée" : "de ${start[1]} à ${end[1]}"}";
  } else {
    return "Du ${start[0].substring(0, start[0].length - 5)} à ${start[1]} au ${end[0].substring(0, end[0].length - 5)} à ${end[1]}";
  }
}

String formatRecurrenceRule(
    DateTime dateStart, DateTime dateEnd, String recurrenceRule, bool allDay) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  String r = "";
  if (recurrenceRule.isEmpty) {
    if (start[0] == end[0]) {
      r += "Le ${start[0].substring(0, start[0].length - 5)} ";
    } else {
      return "Du ${start[0].substring(0, start[0].length - 5)} à ${start[1]} au ${end[0].substring(0, end[0].length - 5)} à ${end[1]}";
    }
  }
  final listDay = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];
  final listDayShort = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"];

  if (recurrenceRule.isNotEmpty) {
    final days = recurrenceRule.split("BYDAY=")[1].split(";")[0].split(",");
    final endDay = recurrenceRule.split("UNTIL=")[1].split(";")[0];
    String res = "";
    if (days.length > 1) {
      for (int i = 0; i < days.length - 1; i++) {
        res += listDay[listDayShort.indexOf(days[i])];
        if (i != days.length - 2) {
          res += ", ";
        }
      }
      res += " et ${listDay[listDayShort.indexOf(days[days.length - 1])]}";
    } else {
      if (listDayShort.contains(days[0])) {
        res += listDay[listDayShort.indexOf(days[0]) - 1];
      }
    }
    r += "Tous les $res ";
    if (!allDay) {
      r += "de ${start[1]} à ${end[1]}";
    } else {
      r += "toute la journée";
    }
    r += " jusqu'au ${processDate(DateTime.parse(endDay))}";
  } else {
    if (!allDay) {
      r += "de ${start[1]} à ${end[1]}";
    } else {
      r += "toute la journée";
    }
  }
  return r;
}

Color generateColor(String uuid) {
  int hash = 0;
  for (int i = 0; i < uuid.length; i++) {
    hash = 20 * hash + uuid.codeUnitAt(i);
  }
  Color color = Color(hash & 0xFFFFFF).withOpacity(1.0);
  double luminance = color.computeLuminance();
  return luminance < 0.5 ? color : invert(color);
}

Color invert(Color color) {
  return Color.fromARGB(
      color.alpha, 255 - color.red, 255 - color.green, 255 - color.blue);
}

List<DateTime> getDateInRecurrence(String recurrenceRule, DateTime start) {
  return SfCalendar.getRecurrenceDateTimeCollection(recurrenceRule, start);
}

DateTime getTrueEnd(Booking b) {
  if (b.recurrenceRule.isEmpty) {
    return b.end;
  } else {
    return getDateInRecurrence(b.recurrenceRule, b.start).last;
  }
}
