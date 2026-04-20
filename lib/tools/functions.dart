import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/providers/permissions_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/plausible/plausible.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/version/repositories/version_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toastification/toastification.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:yaml/yaml.dart';

/// Parses CSV content with automatic separator detection
/// Supports common separators: comma, semicolon, tab, pipe
List<String> parseCsvContent(String content) {
  if (content.isEmpty) return [];

  final separators = [',', ';', '\t', '|'];
  final lines = content.split('\n').where((line) => line.trim().isNotEmpty);

  if (lines.isEmpty) return [];

  // Try to detect the best separator by counting occurrences in the first few lines
  String bestSeparator = ','; // Default to comma
  int maxFieldCount = 0;

  for (final separator in separators) {
    int totalFields = 0;
    int lineCount = 0;

    for (final line in lines.take(3)) {
      // Check first 3 lines
      final fields = line
          .split(separator)
          .where((field) => field.trim().isNotEmpty);
      totalFields += fields.length;
      lineCount++;
    }

    final avgFields = lineCount > 0 ? totalFields / lineCount : 0;
    if (avgFields > maxFieldCount) {
      maxFieldCount = avgFields.round();
      bestSeparator = separator;
    }
  }

  // Parse all lines with the detected separator
  final result = <String>[];
  for (final line in lines) {
    final fields = line
        .split(bestSeparator)
        .map((field) => field.trim())
        .where((field) => field.isNotEmpty && _isValidEmail(field));
    result.addAll(fields);
  }

  return result.toSet().toList(); // Remove duplicates
}

/// Simple email validation helper
bool _isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email.trim());
}

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

String processDateBackWithHourMaybe(String d, String locale) {
  try {
    return DateFormat.yMd(locale).add_Hm().parse(d).toIso8601String();
  } catch (e) {
    return DateFormat.yMd(locale).parse(d).toIso8601String();
  }
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

  if (date == null) return;
  dateController.text = DateFormat.yMd(locale).format(date);
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

  if (date == null) return;
  setDate(DateFormat.yMMMd(locale).format(date));
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
    if (date == null || !context.mounted) return;
    _getTime(context).then((TimeOfDay? time) {
      if (time == null) return;
      dateController.text = DateFormat.yMd(
        locale,
      ).add_Hm().format(DateTimeField.combine(date, time));
    });
  });
}

int generateIntFromString(String s) {
  return s.codeUnits.reduce((value, element) => value + 100 * element);
}

bool hasUserPermission(Ref ref, String permission) {
  final me = ref.watch(userProvider);
  final permissions = ref.watch(mappedPermissionsProvider);
  return me.groups.any(
        (g) => permissions[permission]!.authorizedGroupIds.contains(g.id),
      ) ||
      permissions[permission]!.authorizedAccountTypes.contains(
        me.accountType.type,
      );
}

/// getAppFlavor and functions depending on it

String getAppFlavor() {
  if (appFlavor != null) {
    return appFlavor!.toLowerCase();
  }

  const flavor = String.fromEnvironment("FLAVOR");

  if (flavor.isEmpty) {
    throw StateError("App flavor not set");
  }

  return flavor.toLowerCase();
}

Plausible? getPlausible() {
  const serverUrl = String.fromEnvironment("PLAUSIBLE_HOST");
  const domain = String.fromEnvironment("PLAUSIBLE_DOMAIN");

  if (serverUrl == "" || domain == "") {
    return null;
  }

  if (getAppFlavor() == "prod" || getAppFlavor() == "alpha") {
    return Plausible(serverUrl, domain);
  }

  return null;
}

String getTitanHost() {
  const backendHost = String.fromEnvironment("BACKEND_HOST");
  if (backendHost.isEmpty) {
    throw StateError("Could not find BACKEND_HOST in config.json");
  }
  if (backendHost[backendHost.length - 1] != "/") {
    throw StateError("BACKEND_HOST in config.json should end with a /");
  }

  return backendHost;
}

String getPaymentName() {
  return const String.fromEnvironment("PAYMENT_NAME", defaultValue: "ProxiPay");
}

String getBaseSchoolName() {
  const schoolName = String.fromEnvironment("SCHOOL_NAME");
  if (schoolName.isEmpty) {
    throw StateError("Could not find SCHOOL_NAME in config.json");
  }
  return schoolName;
}

String getTitanURL() {
  const titanUrl = String.fromEnvironment("TITAN_URL");
  if (titanUrl.isEmpty) {
    throw StateError("Could not find TITAN_URL in config.json");
  }
  if (titanUrl[titanUrl.length - 1] != "/") {
    throw StateError("TITAN_URL in config.json should end with a /");
  }
  return titanUrl;
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
  const appIdPrefix = String.fromEnvironment("APP_ID_PREFIX");
  if (appIdPrefix.isEmpty) {
    throw StateError("Could not find APP_ID_PREFIX in config.json");
  }
  return "$appIdPrefix.${getTitanPackageSuffix()}";
}

String getTitanURLScheme() {
  return getTitanPackageName();
}

String getAppName() {
  const appName = String.fromEnvironment("APP_NAME");
  if (appName.isEmpty) {
    throw StateError("Could not find APP_NAME in config.json");
  }
  return appName;
}

String getTitanLogo() {
  return "assets/images/logo_${getAppFlavor()}.png";
}

/// Start of functions to choose back-end

bool isVersionCompatible(String currentVersion, String minimalVersion) {
  final [major, minor, patch] = currentVersion
      .split('.')
      .map(int.parse)
      .toList();
  final [minimalMajor, minimalMinor, minimalPatch] = minimalVersion
      .split('.')
      .map(int.parse)
      .toList();
  if (major < minimalMajor ||
      (major == minimalMajor && minor < minimalMinor) ||
      (major == minimalMajor &&
          minor == minimalMinor &&
          patch < minimalPatch)) {
    return false;
  }
  return true;
}

Future<String> getMinimalHyperionVersion() async {
  final String pubspecString = await rootBundle.loadString("pubspec.yaml");
  final YamlMap pubspec = loadYaml(pubspecString);
  final String minimalHyperionVersion = pubspec["minimal_hyperion_version"];
  return minimalHyperionVersion;
}

Future<String> setHyperionAndGetVersion(String flavor) async {
  Repository.host = getTitanHost(); // set Titan's back-end
  final String hyperionVersion = await VersionRepository().getVersion().then(
    (value) => value.version,
  );
  return hyperionVersion;
}

Future<void> setHyperionHost() async {
  final String flavor = getAppFlavor();
  final String minimalHyperionVersion = await getMinimalHyperionVersion();

  try {
    if (!isVersionCompatible(
      await setHyperionAndGetVersion(flavor),
      minimalHyperionVersion,
    )) {
      if (flavor != "alpha") {
        await setHyperionAndGetVersion("alpha");
      }
    }
  } catch (_) {
    return;
  }
}

/// End of functions to choose back-end and functions depending on getAppFlavor
