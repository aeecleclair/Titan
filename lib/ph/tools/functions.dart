import 'package:intl/intl.dart';

String phFormatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
  return formatter.format(date);
}

String phFormatDateEntry(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy', 'fr_FR');
  return formatter.format(date);
}

String shortenText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength - 3)}...';
  }
}
