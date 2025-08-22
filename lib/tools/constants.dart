import 'package:flutter/material.dart';

class ColorConstants {
  static const Color gradient1 = Color(0xFFfb6d10);
  static const Color gradient2 = Color(0xffeb3e1b);
  static const Color error = Color(0xFFC91717);
  static const Color background2 = Color(0xFF222643);
  static const Color deactivated1 = Color(0xFF9E9E9E);
  static const Color deactivated2 = Color(0xFFC0C0C0);

  static const Color background = Color(0xFFffffff);
  static const Color onBackground = Color(0xffb4b4b4);
  static const Color searchBar = Color(0xfffafafa);
  static const Color secondary = Color(0xFFb1b2b5);
  static const Color tertiary = Color(0xFF424242);
  static const Color onTertiary = Color(0xFF212121);
  static const Color title = Color(0xFF000000);
  static const Color main = Color(0xFFed0000);
  static const Color onMain = Color(0xFFaa0202);
  static const Color mainBorder = Color(0xFF950303);
}

const String previousEmailRegex =
    r'^[\w\-.]*@((ecl\d{2})|(alternance\d{4})|(master)|(auditeur)).ec-lyon.fr$';

const String previousStaffEmailRegex = r'^[\w\-.]*@ec-lyon.fr$';

const String studentRegex = r'^[\w\-.]*@etu(-enise)?.ec-lyon.fr$';

const String unableToOpen = 'Impossible d\'ouvrir le lien';

const int maxHyperionFileSize = 4194304;
