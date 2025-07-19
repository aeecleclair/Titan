import 'package:flutter/material.dart';
import 'package:titan/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/l10n/app_localizations.dart';

String decisionToString(Decision d, BuildContext context) {
  switch (d) {
    case Decision.approved:
      return AppLocalizations.of(context)!.bookingConfirmed;
    case Decision.declined:
      return AppLocalizations.of(context)!.bookingDeclined;
    case Decision.pending:
      return AppLocalizations.of(context)!.bookingPending;
  }
}

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
