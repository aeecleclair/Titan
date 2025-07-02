import 'dart:math';

import 'package:flutter/material.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/l10n/app_localizations.dart';

String decisionToString(Decision d, BuildContext context) {
  switch (d) {
    case Decision.approved:
      return AppLocalizations.of(context)!.eventConfirmed;
    case Decision.declined:
      return AppLocalizations.of(context)!.eventDeclined;
    case Decision.pending:
      return AppLocalizations.of(context)!.eventPending;
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

String getLocalizedEventDay(BuildContext context, String key) {
  final loc = AppLocalizations.of(context)!;
  switch (key) {
    case 'eventDayMon':
      return loc.eventDayMon;
    case 'eventDayTue':
      return loc.eventDayTue;
    case 'eventDayWed':
      return loc.eventDayWed;
    case 'eventDayThu':
      return loc.eventDayThu;
    case 'eventDayFri':
      return loc.eventDayFri;
    case 'eventDaySat':
      return loc.eventDaySat;
    case 'eventDaySun':
      return loc.eventDaySun;
    default:
      return key;
  }
}
