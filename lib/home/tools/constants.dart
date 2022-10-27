import 'package:flutter/material.dart';

class HomeColorConstants {
  static const Color darkBlue = Color(0xFF013144);
  static const Color lightBlue = Color(0xFF025468);
  static const Color gradient1 = Color(0xFFfb6d10);
  static const Color gradient2 = Color(0xffeb3e1b);
}

class HomeTextConstants {
  static const String calendar = "Calendrier";
  static const String eventOf = "Évènements du";
  static const String incomingEvents = "Évènements à venir";
  static const String lastInfos = "Dernières annonces";

  static const Map<String, String> translateDayShort = {
    'Mon': 'Lun',
    'Tue': 'Mar',
    'Wed': 'Mer',
    'Thu': 'Jeu',
    'Fri': 'Ven',
    'Sat': 'Sam',
    'Sun': 'Dim',
  };
}
