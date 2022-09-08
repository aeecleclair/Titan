import 'package:flutter/material.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

void displayEventToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      EventColorConstants.accentColor,
      EventColorConstants.accentColorDark,
      EventColorConstants.primaryColor,
      EventColorConstants.primaryColorDark,
      Colors.white);
}

String calendarEventTypeToString(CalendarEventType type) {
  switch (type) {
    case CalendarEventType.eventAE:
      return "Event AE";
    case CalendarEventType.eventUSE:
      return "Event USE";
    case CalendarEventType.happyHour:
      return "HH";
    case CalendarEventType.direction:
      return "Strass";
    case CalendarEventType.nightParty:
      return "Soirée";
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
    case "HH":
      return CalendarEventType.happyHour;
    case "Strass":
      return CalendarEventType.direction;
    case "Soirée":
      return CalendarEventType.nightParty;
    case "Autre":
      return CalendarEventType.other;
    default:
      return CalendarEventType.other;
  }
}
