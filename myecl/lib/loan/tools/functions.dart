String processDate(DateTime date) {
  final d = date.toIso8601String().split('T')[0].split('-');
  return d[2].toString().padLeft(2, "0") +
      "/" +
      d[1].toString().padLeft(2, "0") +
      "/" +
      d[0].toString();
}

String capitalize(String s) {
  return s[0].toUpperCase() + s.substring(1);
}