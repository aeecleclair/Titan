import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/l10n/app_localizations.dart';

String weekDayToLocalizedString(BuildContext context, WeekDays day) {
  final loc = AppLocalizations.of(context)!;
  switch (day) {
    case WeekDays.monday:
      return loc.bookingWeekDayMon;
    case WeekDays.tuesday:
      return loc.bookingWeekDayTue;
    case WeekDays.wednesday:
      return loc.bookingWeekDayWed;
    case WeekDays.thursday:
      return loc.bookingWeekDayThu;
    case WeekDays.friday:
      return loc.bookingWeekDayFri;
    case WeekDays.saturday:
      return loc.bookingWeekDaySat;
    case WeekDays.sunday:
      return loc.bookingWeekDaySun;
  }
}
