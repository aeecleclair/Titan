import 'package:flutter/material.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

void displayEventToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      EventColorConstants.blueGradient1,
      EventColorConstants.blueGradient2,
      EventColorConstants.redGradient1,
      EventColorConstants.redGradient2,
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

String processDateOnlyHour(DateTime date) {
  return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

List<String> parseDate(DateTime date) {
  return [
    "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
    "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}"
  ];
}

String formatDates(DateTime dateStart, DateTime dateEnd) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  if (start[0] == end[0]) {
    return "De ${start[1]} à ${end[1]}";
  } else {
    return "Du ${start[0]} à ${start[1]} au ${end[0]} à ${end[1]}";
  }
}

String formatDateOnlyHour(DateTime dateStart, DateTime dateEnd) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  return "De ${start[1]} à ${end[1]}";
}

String formatDateOnlyDay(DateTime dateStart, DateTime dateEnd) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  if (start[0] == end[0]) {
    return "Le ${start[0]}";
  } else {
    return "Du ${start[0]} au ${end[0]}";
  }
}

String formatDays(String recurrenceRule) {
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
  final days = recurrenceRule.split("BYDAY=")[1].split(";")[0].split(",");
  String res = "";
  if (days.length > 1) {
    for (int i = 0; i < days.length - 1; i++) {
      res += listDay[listDayShort.indexOf(days[i]) - 1];
      if (i != days.length - 2) {
        res += ", ";
      }
    }
    res += " et ${listDay[listDayShort.indexOf(days[days.length - 1]) - 1]}";
  } else {
    res += listDay[listDayShort.indexOf(days[0]) - 1];
  }
  return res;
}
