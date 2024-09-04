import 'package:flutter/material.dart';

class ColorConstants {
  static const Color gradient1 = Color(0xFFfb6d10);
  static const Color gradient2 = Color(0xffeb3e1b);
  static const Color error = Color(0xFFC91717);
  static const Color background2 = Color(0xFF222643);
  static const Color deactivated1 = Color(0xFF9E9E9E);
  static const Color deactivated2 = Color(0xFFC0C0C0);
}

class TextConstants {
  static const String admin = 'Admin';
  static const String error = "Une erreur est survenue";
  static const String noValue = "Veuillez entrer une valeur";
  static const String invalidNumber = "Veuillez entrer un nombre";
  static const String noDateError = "Veuillez entrer une date";
  static const String imageSizeTooBig =
      "La taille de l'image ne doit pas dépasser 4 Mio";
  static const String imageError = "Erreur lors de l'ajout de l'image";
}

const String previousEmailRegex =
    r'^[\w\-.]*@((ecl\d{2})|(alternance\d{4})|(master)|(auditeur)).ec-lyon.fr$';

const String studentRegex = r'^[\w\-.]*@etu(-enise)?.ec-lyon.fr$';

const String unableToOpen = 'Impossible d\'ouvrir le lien';

const int maxHyperionFileSize = 4194304;
