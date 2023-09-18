import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/constants.dart';
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
        res += listDay[(listDayShort.indexOf(days[0]))];
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
    hash = (10 * hash + uuid.codeUnitAt(i)) % 0xFFFFFF;
  }
  Color color = Color(hash & 0xFFAAFF).withOpacity(1.0);
  return color;
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
    final days = b.recurrenceRule.split("BYDAY=")[1].split(";")[0].split(",");
    if (days.length > 1) {
      final date = getDateInRecurrence(b.recurrenceRule, b.start).last;
      return DateTime(
          date.year, date.month, date.day, b.end.hour, b.end.minute);
    }
    return b.end;
  }
}

DateTime combineDate(DateTime date, DateTime time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

Future<TimeOfDay?> _getTime(BuildContext context) async {
  return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.gradient1,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      });
}

Future<DateTime?> _getDate(BuildContext context, DateTime now) async {
  return await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: now,
    lastDate: DateTime(now.year + 1, now.month, now.day),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorConstants.gradient1,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
}

getOnlyDayDate(
    BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final DateTime? date = await _getDate(context, now);

  dateController.text = DateFormat('dd/MM/yyyy')
      .format(date ?? now.add(const Duration(hours: 1)));
}


getOnlyHourDate(
    BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final TimeOfDay? time = await _getTime(context);

  dateController.text = DateFormat('HH:mm')
      .format(DateTimeField.combine(now, time));
}

getFullDate(
    BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  _getDate(context, now).then(
    (DateTime? date) {
      if (date != null) {
        _getTime(context).then(
          (TimeOfDay? time) {
            if (time != null) {
              dateController.text = DateFormat('dd/MM/yyyy HH:mm')
                  .format(DateTimeField.combine(date, time));
            }
          },
        );
      } else {
        dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(now);
      }
    },
  );
}