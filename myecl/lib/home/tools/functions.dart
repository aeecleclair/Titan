String doubleToTime(double d) {
  int h = d.toInt();
  int m = ((d - h) * 60).toInt();
  String s = "";
  s += h != 0 ? "${h}h" : "";
  s += m != 0 ? "$m" : "";
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