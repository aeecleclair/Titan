import 'package:flutter/material.dart';

class ColorConstants {
  static const Color gradient1 = Color(0xFFfb6d10);
  static const Color gradient2 = Color(0xffeb3e1b);
  static const Color error = Color(0xFFC91717);
  static const Color background2 = Color(0xFF222643);
}

class TextConstants {
  static const String admin = 'Admin';
  static const String error = "Une erreur est survenue";
  static const String noValue = "Veuillez entrer une valeur";
  static const String invalidNumber = "Veuillez entrer un nombre";
  static const String noDateError = "Veuillez entrer une date";
}
const String previousEmailRegex =
    r'^[\w\-.]*@((ecl\d{2})|(alternance\d{4})|(master)|(auditeur)).ec-lyon.fr$';

const String studentRegex = r'^[\w\-.]*@etu(-enise)?.ec-lyon.fr$';

const String unableToOpen = 'Impossible d\'ouvrir le lien';