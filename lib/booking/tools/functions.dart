import 'package:flutter/material.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

void displayBookingToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      BookingColorConstants.gradient1,
      BookingColorConstants.gradient2,
      BookingColorConstants.background2,
      Colors.black,
      Colors.white);
}

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

String formatDates(DateTime dateStart, DateTime dateEnd) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  if (start[0] == end[0]) {
    return "Le ${start[0].substring(0, start[0].length - 5)} de ${start[1]} à ${end[1]}";
  } else {
    return "Du ${start[0].substring(0, start[0].length - 5)} à ${start[1]} au ${end[0].substring(0, end[0].length - 5)} à ${end[1]}";
  }
}
