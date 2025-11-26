import 'package:flutter/material.dart';

class DrawerColorConstants {
  static final Color lightText = Colors.grey.shade100.withValues(alpha: 0.6);
  static final Color selectedText = Colors.grey.shade100;
  static const Color lightBlue = Color.fromARGB(255, 86, 95, 95);
  static const Color darkBlue = Color.fromARGB(255, 62, 62, 62);
  static const Color fakePageBlue = Color.fromARGB(24, 161, 161, 161);
  static const Color fakePageShadow = Color.fromARGB(14, 161, 161, 161);
}

class DrawerTextConstants {
  static const String admin = "Administration";
  static const String androidAppLink =
      "https://play.google.com/store/apps/details?id=fr.myecl.titan";
  static const String copied = "Copié !";
  static const String downloadAppOnMobileDevice =
      "Ce site est la version Web de l'application MyECL. Nous vous invitons à télécharger l'application. N'utilisez ce site qu'en cas de problème avec l'application.\n";
  static const String iosAppLink =
      "https://apps.apple.com/fr/app/myecl/id6444443430";
  static const String loginOut = "Voulez-vous vous déconnecter ?";
  static const String logOut = "Déconnexion";
  static const String or = " ou ";
  static const String restrictedAccount = "Compte restreint";
  static const String settings = "Paramètres";
}
