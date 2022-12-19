import 'package:myecl/event/class/event.dart';
import 'package:myecl/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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

List<String> parseDate(DateTime date) {
  return [
    "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
    "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}"
  ];
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
      res += listDay[listDayShort.indexOf(days[0]) - 1];
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

DateTime normalizedDate(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
}

DateTime mergeDates(DateTime date, DateTime time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

List<DateTime> getDateInRecurrence(String recurrenceRule, DateTime start) {
  return SfCalendar.getRecurrenceDateTimeCollection(recurrenceRule, start);
}

int dayDifference(DateTime start, DateTime end) {
  return end.difference(start).inDays;
}

String formatDelayToToday(DateTime date, DateTime now) {
  final strNow = processDateToAPIWitoutHour(now);
  final strDate = processDateToAPIWitoutHour(date);
  final diff = dayDifference(now, date);
  if (now.year > date.year) {
    return "Il y a ${now.year - date.year} ans";
  } else if (now.month > date.month) {
    return "Il y a ${now.month - date.month} mois";
  } else if (diff == -1) {
    return "Hier";
  } else if (now.month > date.month && now.day - date.day > 1) {
    return "Il y a ${now.day - date.day} jours";
  } else if (diff == 0) {
    return "Aujourd'hui";
  } else if (diff == 1) {
    return "Demain";
  } else if (((now.month < date.month ||
          (strDate.compareTo(strNow) > 0 && now.month >= date.month)) &&
      diff < 14)) {
    return "Dans $diff jours";
  } else {
    return "En ${getMonth(date.month)}";
  }
}
