import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/admin/providers/permissions_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:titan/tools/plausible/plausible.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/user/providers/user_provider.dart';

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
  LinearGradient linearGradient;
  HeroIcons icon;

  switch (type) {
    case TypeMsg.msg:
      linearGradient = const LinearGradient(
        colors: [ColorConstants.gradient1, ColorConstants.gradient2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      icon = HeroIcons.check;
      duration = duration ?? 1500;
      break;
    case TypeMsg.error:
      linearGradient = const LinearGradient(
        colors: [ColorConstants.background2, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      icon = HeroIcons.exclamationTriangle;
      duration = duration ?? 3000;
      break;
  }

  showFlash(
    context: context,
    duration: Duration(milliseconds: duration),
    builder: (context, controller) {
      return FlashBar(
        position: FlashPosition.top,
        controller: controller,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
        content: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            gradient: linearGradient,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 50 + text.length / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                alignment: Alignment.center,
                child: HeroIcon(icon, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
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

String processDate(DateTime date) {
  return "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";
}

String processDateWithHour(DateTime date) {
  return "${processDate(date)} ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
}

String processDatePrint(String d) {
  if (d == "") {
    return "";
  }
  List<String> e = d.split("-");
  return "${e[2].toString().padLeft(2, "0")}/${e[1].toString().padLeft(2, "0")}/${e[0]}";
}

String processDateBack(String d) {
  if (d == "") {
    return "";
  }
  List<String> e = d.split("/");
  if (e[2].contains(" ")) {
    return "${e[2].split(" ")[0]}-${e[1].toString().padLeft(2, "0")}-${e[0]} ${e[2].split(" ")[1]}";
  }
  return "${e[2].toString().padLeft(2, "0")}-${e[1].toString().padLeft(2, "0")}-${e[0]}";
}

String processDateBackWithHour(String d) {
  if (d == "") {
    return "";
  }
  List<String> e = d.split(" ");
  if (e.length == 1) {
    return processDateBack(e[0]);
  }
  return "${processDateBack(e[0])} ${e[1]}";
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
    r += " jusqu'au ${processDate(DateTime.parse(endDay))}";
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
            primary: ColorConstants.gradient1,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
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
            primary: ColorConstants.gradient1,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
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
  final DateTime now = DateTime.now();
  final DateTime? date = await _getDate(
    context,
    now,
    initialDate,
    firstDate,
    lastDate,
  );

  dateController.text = DateFormat(
    'dd/MM/yyyy',
  ).format(date ?? initialDate ?? now);
}

Future getOnlyDayDateFunction(
  BuildContext context,
  void Function(String) setDate, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final DateTime now = DateTime.now();
  final DateTime? date = await _getDate(
    context,
    now,
    initialDate,
    firstDate,
    lastDate,
  );

  setDate(DateFormat('dd/MM/yyyy').format(date ?? initialDate ?? now));
}

Future getOnlyHourDate(
  BuildContext context,
  TextEditingController dateController,
) async {
  final DateTime now = DateTime.now();
  final TimeOfDay? time = await _getTime(context);

  dateController.text = DateFormat(
    'HH:mm',
  ).format(DateTimeField.combine(now, time));
}

Future getFullDate(
  BuildContext context,
  TextEditingController dateController, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final DateTime now = DateTime.now();
  _getDate(context, now, initialDate, firstDate, lastDate).then((
    DateTime? date,
  ) {
    if (date != null && context.mounted) {
      _getTime(context).then((TimeOfDay? time) {
        if (time != null) {
          dateController.text = DateFormat(
            'dd/MM/yyyy HH:mm',
          ).format(DateTimeField.combine(date, time));
        }
      });
    } else {
      dateController.text = DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(initialDate ?? now);
    }
  });
}

int generateIntFromString(String s) {
  return s.codeUnits.reduce((value, element) => value + 100 * element);
}

bool hasUserPermission(Ref ref, String permission) {
  final me = ref.watch(userProvider);
  final permissions = ref.watch(permissionsProvider);
  return me.groups.any(
        (g) => permissions[permission]!.authorizedGroups.contains(g.id),
      ) ||
      permissions[permission]!.authorizedAccountTypes.contains(
        me.accountType.type,
      );
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

String getTitanURLScheme() {
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
  return "fr.myecl.${getTitanURLScheme()}";
}

String getTitanLogo() {
  return "assets/images/logo_${getAppFlavor()}.png";
}
