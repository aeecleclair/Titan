import 'package:intl/intl.dart';

String phFormatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
  return formatter.format(date);
}
