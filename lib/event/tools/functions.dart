import 'dart:math';

import 'package:titan/event/class/event.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/tools/functions.dart';

String decisionToString(Decision d) {
  switch (d) {
    case Decision.approved:
      return EventTextConstants.confirmed;
    case Decision.declined:
      return EventTextConstants.declined;
    case Decision.pending:
      return EventTextConstants.pending;
  }
}

String calendarEventTypeToString(CalendarEventType type) {
  switch (type) {
    case CalendarEventType.eventAE:
      return "Event AE";
    case CalendarEventType.eventUSE:
      return "Event USE";
    case CalendarEventType.independentAssociation:
      return "Asso indé";
    case CalendarEventType.happyHour:
      return "HH";
    case CalendarEventType.direction:
      return "Strass";
    case CalendarEventType.nightParty:
      return "Rewass";
    case CalendarEventType.other:
      return "Autre";
  }
}

CalendarEventType stringToCalendarEventType(String type) {
  switch (type) {
    case "Event AE":
      return CalendarEventType.eventAE;
    case "Event USE":
      return CalendarEventType.eventUSE;
    case "Asso indé":
      return CalendarEventType.independentAssociation;
    case "HH":
      return CalendarEventType.happyHour;
    case "Strass":
      return CalendarEventType.direction;
    case "Rewass":
      return CalendarEventType.nightParty;
    case "Autre":
      return CalendarEventType.other;
    default:
      return CalendarEventType.other;
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
