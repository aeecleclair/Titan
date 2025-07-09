import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';

String getShortDayLabel(BuildContext context, DateTime day) {
  final loc = AppLocalizations.of(context)!;
  final String weekday = DateFormat('E').format(day); // ex: Mon, Tue, etc.

  switch (weekday) {
    case 'Mon':
      return loc.homeTranslateDayShortMon;
    case 'Tue':
      return loc.homeTranslateDayShortTue;
    case 'Wed':
      return loc.homeTranslateDayShortWed;
    case 'Thu':
      return loc.homeTranslateDayShortThu;
    case 'Fri':
      return loc.homeTranslateDayShortFri;
    case 'Sat':
      return loc.homeTranslateDayShortSat;
    case 'Sun':
      return loc.homeTranslateDayShortSun;
    default:
      return weekday;
  }
}
