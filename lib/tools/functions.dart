import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum TypeMsg { msg, error }

void displayToast(BuildContext context, TypeMsg type, String text) {
  LinearGradient linearGradient;
  int duration;
  HeroIcons icon;

  switch (type) {
    case TypeMsg.msg:
      linearGradient = const LinearGradient(
          colors: [ColorConstants.gradient1, ColorConstants.gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.check;
      duration = 1500;
      break;
    case TypeMsg.error:
      linearGradient = const LinearGradient(
          colors: [ColorConstants.background2, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.exclamationTriangle;
      duration = 3000;
      break;
  }

  showFlash(
      context: context,
      duration: Duration(milliseconds: duration),
      builder: (context, controller) {
        return FlashBar(
          position: FlashPosition.top,
          controller: controller,
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      maxLines: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
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
      .splitMapJoin(RegExp('(${splitters.join('|')})'),
          onMatch: (m) => m.group(0) ?? '', onNonMatch: (n) => capitalize(n))
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
  return "${processDateBack(e[0])} ${e[1]}";
}

String processDateToAPI(DateTime date) {
  return date.toIso8601String();
}

String processDateToAPIWithoutHour(DateTime date) {
  return date.toIso8601String().split('T')[0];
}


int generateIntFromString(String s) {
  return s.codeUnits.reduce(
    (value, element) => value + 100 * element,
  );
}

bool isEmailInValid(String email) {
  final regex = RegExp(previousEmailRegex);
  return regex.hasMatch(email);
}

bool isStudent(String email) {
  final regex = RegExp(studentRegex);
  return regex.hasMatch(email);
}