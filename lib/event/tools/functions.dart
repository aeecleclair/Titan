import 'dart:math';

import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';

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
