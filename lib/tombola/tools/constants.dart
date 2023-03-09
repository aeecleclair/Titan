import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class TombolaColorConstants extends ColorConstants {

  static final Color lightGradientButton = Color.fromARGB(255, 192, 6, 18);
  static final Color darkGradientButton = Color.fromARGB(255, 97, 15, 0);
  static final Color darkText = Color.fromARGB(255, 50, 9, 1);
  static final Color writtenDark = Color.fromARGB(255, 10, 9, 30);
  static final Color writtenWhite = Color(0xfffafaeb);

  
  
}

class TombolaTextConstants {
  //general
  static const String raffle = "Tombola";
  static const String prize = "Lots";
  //Home page
  static const String actualTombolas = "Tombola en cours";
  static const String pastTombolas = "Tombola passés";
  static const String tickets = "Tous vos tickets";
  static const String createMenu = "Menu de Création";
  static const String nextTombolas = "Prochaines tombolas";
  static const String noTicket = "Vous n'avez pas de ticket";

  //Tombola page
  static const String actualPrize = "Lots actuels";
  static const String takeTickets = "Prendre vos tickets";
  static const String noTicketBuyable = "Vous ne pouvez pas achetez de billets pour l'instant, voir avec les organisateurs de la tombola";
  static const String noPrize = "Il n'y a aucun lots actuellement, honte aux organisateurs de la tombola";
  //Create Home
  static const String modifTombola =
      "Vous pouvez modifiez vos tombolas ou en créer de nouvelles, toute décision doit ensuite être prise par les admins";
  static const String createYourRaffle = "Votre menu de création de tombolas";

  //Add Edit Page
  static const String possiblePrice = "Prix possible";
  static const String information = "Information et Statistiques";


}
