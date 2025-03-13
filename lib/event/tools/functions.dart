import 'dart:math';

import 'package:myecl/generated/openapi.enums.swagger.dart';

String calendarEventTypeToString(CalendarEventType type) {
  switch (type) {
    case CalendarEventType.eventAe:
      return "Event AE";
    case CalendarEventType.eventUse:
      return "Event USE";
    case CalendarEventType.assoInd:
      return "Asso indé";
    case CalendarEventType.hh:
      return "HH";
    case CalendarEventType.strass:
      return "Strass";
    case CalendarEventType.rewass:
      return "Rewass";
    case CalendarEventType.autre:
      return "Autre";
    case CalendarEventType.swaggerGeneratedUnknown:
      return "Autre";
  }
}

CalendarEventType stringToCalendarEventType(String type) {
  switch (type) {
    case "Event AE":
      return CalendarEventType.eventAe;
    case "Event USE":
      return CalendarEventType.eventUse;
    case "Asso indé":
      return CalendarEventType.assoInd;
    case "HH":
      return CalendarEventType.hh;
    case "Strass":
      return CalendarEventType.strass;
    case "Rewass":
      return CalendarEventType.rewass;
    case "Autre":
      return CalendarEventType.autre;
    default:
      return CalendarEventType.autre;
  }
}

String processDateOnlyHour(DateTime date) {
  return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

DateTime mergeDates(DateTime date, DateTime time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

int dayDifference(DateTime start, DateTime end) {
  return end.difference(start).inDays;
}

String formatDelayToToday(DateTime date, DateTime now) {
  final diff = dayDifference(now, date);
  if (diff == 0) {
    return "Aujourd'hui";
  } else if (diff == 1) {
    return "Demain";
  } else if (diff < 31) {
    return "Dans $diff jours";
  } else if (12 * max(0, date.year - now.year) + date.month - now.month < 12) {
    return "Dans ${(date.month - now.month) % 12} mois";
  }
  return "Dans ${date.year - now.year} ans";
}
