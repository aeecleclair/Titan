import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

enum TypeMsg { msg, error }

void displayToast(
    BuildContext context,
    TypeMsg type,
    String text,
    Color msgGradient1,
    Color msgGradient2,
    Color errorGradient1,
    Color errorGradient2,
    Color textColor) {
  LinearGradient linearGradient;
  HeroIcons icon;

  switch (type) {
    case TypeMsg.msg:
      linearGradient = LinearGradient(
          colors: [msgGradient1, msgGradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.check;
      break;
    case TypeMsg.error:
      linearGradient = LinearGradient(
          colors: [errorGradient1, errorGradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.exclamation;
      break;
  }

  showFlash(
      context: context,
      duration: const Duration(milliseconds: 1500),
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          backgroundGradient: linearGradient,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: HeroIcon(icon, color: textColor),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: textColor),
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
  return s[0].toUpperCase() + s.substring(1);
}

String processDate(DateTime date) {
  return date.day.toString().padLeft(2, "0") +
      "/" +
      date.month.toString().padLeft(2, "0") +
      "/" +
      date.year.toString();
}

String processDatePrint(String d) {
  List<String> e = d.split("-");
  return e[2].toString().padLeft(2, "0") +
      "/" +
      e[1].toString().padLeft(2, "0") +
      "/" +
      e[0].toString();
}

String processDateToAPI(DateTime date) {
  return date.toIso8601String();
}


