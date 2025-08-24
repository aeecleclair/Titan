import 'package:intl/intl.dart';

String phFormatDate(DateTime date, String locale) {
  final DateFormat formatter = DateFormat.yMMMMd(locale);
  return formatter.format(date);
}

String phFormatDateEntry(DateTime date, String locale) {
  final DateFormat formatter = DateFormat.yMMMd(locale);
  return formatter.format(date);
}

String shortenText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength - 3)}...';
  }
}
