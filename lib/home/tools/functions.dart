import 'package:flutter/material.dart';

String doubleToTime(double d) {
  int h = d.toInt();
  int m = ((d - h) * 60).toInt();
  String s = "";
  s += h != 0 ? h.toString() + "h" : "";
  s += m != 0 ? m.toString().padLeft(2, '0') : "";
  s += h == 0 && m != 0 ? "min" : "";
  return s;
}

String getMonth(int m) {
  switch (m) {
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
      return const Color(0xFFf6a278);
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
      return const Color(0xFFee4540);
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
