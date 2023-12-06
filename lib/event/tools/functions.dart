import 'dart:math';

import 'package:myecl/generated/openapi.swagger.dart';

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

String getApplicantName(EventApplicant applicant) {
  if (applicant.nickname != null && applicant.nickname!.isNotEmpty) {
    return "${applicant.nickname} (${applicant.firstname} ${applicant.name})";
  }
  return "${applicant.firstname} ${applicant.name}";
}