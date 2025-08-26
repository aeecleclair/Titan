import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/plausible/plausible.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toastification/toastification.dart';

enum TypeMsg { msg, error }

enum Decision { approved, declined, pending }

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

void displayToast(
  BuildContext context,
  TypeMsg type,
  String text, {
  int? duration,
}) {
  String title;
  Color primaryColor, textColor;
  ToastificationType toastType;
  final localization = AppLocalizations.of(context)!;

  switch (type) {
    case TypeMsg.msg:
      title = localization.toolSuccess;
      primaryColor = ColorConstants.background;
      textColor = ColorConstants.tertiary;
      toastType = ToastificationType.success;
      break;
    case TypeMsg.error:
      title = localization.adminError;
      primaryColor = ColorConstants.onMain;
      textColor = ColorConstants.background;
      toastType = ToastificationType.error;
      break;
  }

  toastification.show(
    context: context,
    type: toastType,
    style: ToastificationStyle.fillColored,
    alignment: Alignment.topCenter,
    title: Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
    ),
    showIcon: false,
    primaryColor: primaryColor,
    showProgressBar: false,
    closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    autoCloseDuration: const Duration(milliseconds: 2500),
    animationDuration: const Duration(milliseconds: 400),
    animationBuilder: (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        child: Opacity(opacity: animation.value, child: child),
      );
    },
  );
}

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

String capitaliseAll(String s) {
  final splitters = [' ', '-', '_'];
  if (s.isEmpty) {
    return s;
  }
  return s
      .splitMapJoin(
        RegExp('(${splitters.join('|')})'),
        onMatch: (m) => m.group(0) ?? '',
        onNonMatch: (n) => capitalize(n),
      )
      .trim();
}

bool isDateBefore(String date1, String date2) {
  final d1 = DateTime.parse(date1);
  final d2 = DateTime.parse(date2);
  return d1.isBefore(d2);
}

String processDatePrint(String d) {
  if (d == "") {
    return "";
  }
  List<String> e = d.split("-");
  return "${e[2].toString().padLeft(2, "0")}/${e[1].toString().padLeft(2, "0")}/${e[0]}";
}

String processDateBack(String d, String locale) {
  return DateFormat.yMd(locale).parse(d).toIso8601String().split("T")[0];
}

String processDateBackWithHour(String d, String locale) {
  return DateFormat.yMd(locale).add_Hm().parse(d).toIso8601String();
}

List<DateTime> getDateInRecurrence(String recurrenceRule, DateTime start) {
  if (recurrenceRule.isEmpty) {
    return [];
  }
  return SfCalendar.getRecurrenceDateTimeCollection(recurrenceRule, start);
}

DateTime normalizedDate(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
}

String processDateToAPI(DateTime date) {
  return date.toUtc().toIso8601String();
}

String processDateToAPIWithoutHour(DateTime date) {
  return date.toIso8601String().split("T")[0];
}

DateTime processDateFromAPI(String date) {
  return DateTime.parse(date).toLocal();
}

DateTime processDateFromAPIWithoutHour(String date) {
  return DateTime.parse(date);
}

String formatDates(DateTime dateStart, DateTime dateEnd, bool allDay) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  final displayYear = dateEnd.year != DateTime.now().year;
  if (start[0] == end[0]) {
    return "Le ${start[0].substring(0, start[0].length - (displayYear ? 0 : 5))} ${allDay ? "toute la journée" : "de ${start[1]} à ${end[1]}"}";
  }
  return "Du ${start[0].substring(0, start[0].length - (displayYear ? 0 : 5))} à ${start[1]} au ${end[0].substring(0, end[0].length - (displayYear ? 0 : 5))} à ${end[1]}";
}

List<String> parseDate(DateTime date) {
  return [
    "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
    "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
  ];
}

String formatRecurrenceRule(
  DateTime dateStart,
  DateTime dateEnd,
  String recurrenceRule,
  bool allDay,
  String locale,
) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  final displayYear = dateEnd.year != DateTime.now().year;
  String r = "";
  if (recurrenceRule.isEmpty) {
    if (start[0] == end[0]) {
      r +=
          "Le ${start[0].substring(0, start[0].length - (displayYear ? 0 : 5))} ";
    } else {
      return "Du ${start[0].substring(0, start[0].length - (displayYear ? 0 : 5))} à ${start[1]} au ${end[0].substring(0, end[0].length - (displayYear ? 0 : 5))} à ${end[1]}";
    }
  }
  final listDay = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche",
  ];
  final listDayShort = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"];

  if (recurrenceRule.isNotEmpty) {
    final days = recurrenceRule.split("BYDAY=")[1].split(";")[0].split(",");
    final endDay = recurrenceRule.split("UNTIL=")[1].split(";")[0];
    String res = "";
    if (days.length > 1) {
      for (int i = 0; i < days.length - 1; i++) {
        res += listDay[listDayShort.indexOf(days[i])];
        if (i != days.length - 2) {
          res += ", ";
        }
      }
      res += " et ${listDay[listDayShort.indexOf(days[days.length - 1])]}";
    } else {
      if (listDayShort.contains(days[0])) {
        res += listDay[(listDayShort.indexOf(days[0]))];
      }
    }
    r += "Tous les $res ";
    if (!allDay) {
      r += "de ${start[1]} à ${end[1]}";
    } else {
      r += "toute la journée";
    }
    r += " jusqu'au ${DateFormat.yMd(locale).format(DateTime.parse(endDay))}";
  } else {
    if (!allDay) {
      r += "de ${start[1]} à ${end[1]}";
    } else {
      r += "toute la journée";
    }
  }
  return r;
}

Color generateColor(String uuid) {
  int hash = 0;
  for (int i = 0; i < uuid.length; i++) {
    hash = (10 * hash + uuid.codeUnitAt(i)) % 0xFFFFFF;
  }
  Color color = Color(hash & 0xFFAAFF).withValues(alpha: 1.0);
  return color;
}

DateTime combineDate(DateTime date, DateTime time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

String getMonth(int m) {
  final months = [
    "Décembre",
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
  ];
  return months[m % 12];
}

Future<TimeOfDay?> _getTime(BuildContext context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorConstants.main,
            onPrimary: ColorConstants.background,
            surface: ColorConstants.background,
            onSurface: ColorConstants.tertiary,
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: ColorConstants.background,
          ),
        ),
        child: child!,
      );
    },
  );
}

Future<DateTime?> _getDate(
  BuildContext context,
  DateTime now,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: firstDate ?? now,
    lastDate: lastDate ?? DateTime(now.year + 1, now.month, now.day),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorConstants.main,
            onPrimary: ColorConstants.background,
            surface: ColorConstants.background,
            onSurface: ColorConstants.tertiary,
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: ColorConstants.background,
          ),
        ),
        child: child!,
      );
    },
  );
}

Future getOnlyDayDate(
  BuildContext context,
  TextEditingController dateController, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final locale = Localizations.localeOf(context).toString();
  final DateTime now = DateTime.now();
  final DateTime? date = await _getDate(
    context,
    now,
    initialDate,
    firstDate,
    lastDate,
  );

  dateController.text = DateFormat.yMd(
    locale,
  ).format(date ?? initialDate ?? now);
}

Future getOnlyDayDateFunction(
  BuildContext context,
  void Function(String) setDate, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final locale = Localizations.localeOf(context).toString();
  final DateTime now = DateTime.now();
  final DateTime? date = await _getDate(
    context,
    now,
    initialDate,
    firstDate,
    lastDate,
  );

  setDate(DateFormat.yMMMd(locale).format(date ?? initialDate ?? now));
}

Future getOnlyHourDate(
  BuildContext context,
  TextEditingController dateController,
) async {
  final locale = Localizations.localeOf(context).toString();
  final DateTime now = DateTime.now();
  final TimeOfDay? time = await _getTime(context);

  dateController.text = DateFormat.Hm(
    locale,
  ).format(DateTimeField.combine(now, time));
}

Future getFullDate(
  BuildContext context,
  TextEditingController dateController, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final locale = Localizations.localeOf(context).toString();
  final DateTime now = DateTime.now();
  _getDate(context, now, initialDate, firstDate, lastDate).then((
    DateTime? date,
  ) {
    if (date != null && context.mounted) {
      _getTime(context).then((TimeOfDay? time) {
        if (time != null) {
          dateController.text = DateFormat.yMd(
            locale,
          ).add_Hm().format(DateTimeField.combine(date, time));
        }
      });
    } else {
      dateController.text = DateFormat.yMd(
        locale,
      ).add_Hm().format(initialDate ?? now);
    }
  });
}

int generateIntFromString(String s) {
  return s.codeUnits.reduce((value, element) => value + 100 * element);
}

bool isEmailInValid(String email) {
  final regex = RegExp(previousEmailRegex);
  return regex.hasMatch(email);
}

bool isStudent(String email) {
  final regex = RegExp(studentRegex);
  return regex.hasMatch(email);
}

bool isNotStaff(String email) {
  final regex = RegExp(previousStaffEmailRegex);
  return !regex.hasMatch(email);
}

String getAppFlavor() {
  if (appFlavor != null) {
    return appFlavor!.toLowerCase();
  }

  if (const String.fromEnvironment("flavor") != "") {
    return const String.fromEnvironment("flavor");
  }

  throw StateError("App flavor not set");
}

Plausible? getPlausible() {
  final serverUrl = dotenv.env["PLAUSIBLE_HOST"];
  final domain = dotenv.env["PLAUSIBLE_DOMAIN"];

  if (serverUrl == null || domain == null) {
    return null;
  }

  if (getAppFlavor() == "prod" || getAppFlavor() == "alpha") {
    return Plausible(serverUrl, domain);
  }

  return null;
}

String getTitanHost() {
  var host = dotenv.env["${getAppFlavor().toUpperCase()}_HOST"];

  if (host == null || host == "") {
    throw StateError("Could not find host corresponding to flavor");
  }

  return host;
}

String getPaymentName() {
  var paymentName = dotenv.env["PAYMENT_NAME"];
  if (paymentName == null || paymentName.isEmpty) {
    paymentName = "Payment";
  }
  return paymentName;
}

String getBaseSchoolName() {
  var schoolName = dotenv.env["SCHOOL_NAME"];
  if (schoolName == null || schoolName.isEmpty) {
    throw StateError("Could not find school name in environment variables");
  }
  return schoolName;
}

String getTitanURL() {
  switch (getAppFlavor()) {
    case "dev":
      return "http://localhost:3000";
    case "alpha":
      return "https://titan.dev.eclair.ec-lyon.fr";
    case "prod":
      return "https://myecl.fr";
    default:
      throw StateError("Invalid app flavor");
  }
}

String getTitanPackageSuffix() {
  switch (getAppFlavor()) {
    case "dev":
      return "titan.dev";
    case "alpha":
      return "titan.alpha";
    case "prod":
      return "titan";
    default:
      throw StateError("Invalid app flavor");
  }
}

String getTitanPackageName() {
  return "${String.fromEnvironment('APP_ID_PREFIX')}.${getTitanPackageSuffix()}";
}

String getTitanURLScheme() {
  return getTitanPackageName();
}

String getAppName() {
  return String.fromEnvironment('APP_NAME');
}

String getTitanLogo() {
  return "assets/images/logo_${getAppFlavor()}.png";
}
