import 'package:timeago/timeago.dart';

/// English Messages
class CustomFrMessages implements LookupMessages {
  @override
  String prefixAgo() => 'il y a';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "$seconds secondes";
  @override
  String aboutAMinute(int minutes) => 'environ une minute';
  @override
  String minutes(int minutes) => 'environ $minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'environ une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'environ un jour';
  @override
  String days(int days) => 'environ $days jours';
  @override
  String aboutAMonth(int days) => 'environ un mois';
  @override
  String months(int months) => 'environ $months mois';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}

/// English short Messages
class CustomFrShortMessages implements LookupMessages {
  @override
  String prefixAgo() => 'il y a';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "$seconds secondes";
  @override
  String aboutAMinute(int minutes) => 'une minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'un jour';
  @override
  String days(int days) => '$days jours';
  @override
  String aboutAMonth(int days) => 'un mois';
  @override
  String months(int months) => '$months mois';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}
