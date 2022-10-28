import 'package:flutter/material.dart';
import 'package:myecl/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

String doubleToTime(double d) {
  int h = d.toInt();
  int m = ((d - h) * 60).toInt();
  String s = "";
  s += h != 0 ? "${h}h" : "";
  s += m != 0 ? m.toString().padLeft(2, '0') : "";
  s += h == 0 && m != 0 ? "min" : "";
  return s;
}

String getMonth(int m) {
  switch (m) {
    case 0:
      return "Décembre";
    case 1:
      return "Janvier";
    case 2:
      return "Février";
    case 3:
      return "Mars";
    case 4:
      return "Avril";
    case 5:
      return "Mai";
    case 6:
      return "Juin";
    case 7:
      return "Juillet";
    case 8:
      return "Août";
    case 9:
      return "Septembre";
    case 10:
      return "Octobre";
    case 11:
      return "Novembre";
    case 12:
      return "Décembre";
    default:
      return "";
  }
}

Color uuidToColor(String id) {
  int i = 0;
  for (int j = 0; j < id.length; j++) {
    i += id.codeUnitAt(j);
  }
  i = i % 15;
  switch (i) {
    case 0:
      return const Color(0xFF3B1BBD);
    case 1:
      return const Color(0xFFf16744);
    case 2:
      return const Color(0xFFc73618);
    case 3:
      return const Color(0xFF004a59);
    case 4:
      return const Color(0xFF027184);
    case 5:
      return const Color(0xFF0193a5);
    case 6:
      return const Color(0xFF35bbca);
    case 7:
      return const Color(0xFFc72c41);
    case 8:
      return const Color(0xFF801336);
    case 9:
      return const Color(0xFF510a32);
    case 10:
      return const Color(0xFF2d142c);
    case 11:
      return const Color(0xFFf56a79);
    case 12:
      return const Color(0xFFff414d);
    case 13:
      return const Color(0xFF1aa6b7);
    case 14:
      return const Color(0xFF002d40);
    default:
      return const Color(0xFF004a59);
  }
}

bool isDateBetween(DateTime date, DateTime start, DateTime end) {
  return date.isAfter(start) && date.isBefore(end);
}

DateTime correctBeforeDate(DateTime start) {
  final now = DateTime.now();
  final strNow = processDateToAPIWitoutHour(now);
  if (processDateToAPIWitoutHour(start).compareTo(strNow) < 0) {
    return DateTime(now.year, now.month, now.day, 0, 0);
  }
  return start;
}

DateTime correctAfterDate(DateTime end) {
  final now = DateTime.now();
  final strNow = processDateToAPIWitoutHour(now);
  if (processDateToAPIWitoutHour(end).compareTo(strNow) > 0) {
    return DateTime(now.year, now.month, now.day, 23, 59);
  }
  return end;
}

bool isDateInReccurence(String recurrenceRule, String strNow, DateTime start) {
  final rrule =
      SfCalendar.getRecurrenceDateTimeCollection(recurrenceRule, start);
  final dates = rrule.map((e) => processDateToAPIWitoutHour(e)).toList();
  return dates.contains(strNow);
}

String formatDelayToToday(DateTime date, DateTime now) {
  final strNow = processDateToAPIWitoutHour(now);
  final strDate = processDateToAPIWitoutHour(date);
  if (now.year > date.year) {
    return "Il y a ${now.year - date.year} ans";
  } else if (now.month > date.month) {
    return "Il y a ${now.month - date.month} mois";
  } else if (now.day - date.day == 1) {
    return "Hier";
  } else if (now.day - date.day > 1) {
    return "Il y a ${now.day - date.day} jours";
  } else if (strDate.compareTo(strNow) == 0) {
    return "Aujourd'hui";
  } else if (date.day - now.day == 1) {
    return "Demain";
  } else if ((now.month == date.month) ||
      (now.month != date.month && now.day - date.day < 14)) {
    return "Dans ${date.day - now.day} jours";
  } else {
    return "En ${getMonth(date.month)}";
  }
}

DateTime normalizedDate(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
}
