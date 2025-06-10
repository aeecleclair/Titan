import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class RaffleColorConstants extends ColorConstants {
  static const Color darkText = Color.fromARGB(255, 50, 9, 1);
  static const Color writtenDark = Color.fromARGB(255, 10, 9, 30);
  static const Color writtenWhite = Color(0xfffafaeb);
  static const Color gradient1 = Color(0xff1aa6b7);
  static const Color gradient2 = Color(0xff002d40);
  static const Color blueGradient1 = Color(0xff0193a5);
  static const Color blueGradient2 = Color(0xff004a59);
  static const Color textDark = Color.fromARGB(255, 0, 23, 32);
  static const Color redGradient1 = Color(0xFFfb6d10);
  static const Color redGradient2 = Color.fromARGB(255, 155, 51, 10);
  static const Color redGradient3 = Color.fromARGB(255, 255, 34, 34);
  static const Color ticketBack = Color(0xff000031);
}

class RaffleTextConstants {
  //general
  static const String raffle = "Tombola";
  static const String prize = "Lot";
  static const String prizes = "Lots";
  //Home page
  static const String actualRaffles = "Tombola en cours";
  static const String pastRaffles = "Tombola passés";
  static const String yourTickets = "Tous vos tickets";
  static const String createMenu = "Menu de Création";
  static const String nextRaffles = "Prochaines tombolas";
  static const String noTicket = "Vous n'avez pas de ticket";
  static const String seeRaffleDetail = "Voir lots/tickets";

  //Tombola page
  static const String actualPrize = "Lots actuels";
  static const String majorPrize = "Lot Majeurs";
  static const String takeTickets = "Prendre vos tickets";
  static const String noTicketBuyable =
      "Vous ne pouvez pas achetez de billets pour l'instant";
  static const String noCurrentPrize = "Il n'y a aucun lots actuellement";
  //Create Home
  static const String modifTombola =
      "Vous pouvez modifiez vos tombolas ou en créer de nouvelles, toute décision doit ensuite être prise par les admins";
  static const String createYourRaffle = "Votre menu de création de tombolas";

  //Add Edit Page
  static const String possiblePrice = "Prix possible";
  static const String information = "Information et Statistiques";

  //Admin page
  static const String accounts = "Comptes";
  static const String add = "Ajouter";
  static const String updatedAmount = "Montant mis à jour";
  static const String updatingError = "Erreur lors de la mise à jour";
  static const String deletedPrize = "Lot supprimé";
  static const String deletingError = "Erreur lors de la suppression";
  static const String quantity = "Quantité";
  static const String close = "Fermer";
  static const String open = "Ouvrir";

  // Add Edit type ticket
  static const String addTypeTicketSimple = "Ajouter";
  static const String addingError = "Erreur lors de l'ajout";
  static const String editTypeTicketSimple = "Modifier";
  static const String fillField = "Le champ ne peut pas être vide";
  static const String waiting = "Chargement";
  static const String editingError = "Erreur lors de la modification";
  static const String addedTicket = "Ticket ajouté";
  static const String editedTicket = "Ticket modifié";
  static const String alreadyExistTicket = "Le ticket existe déjà";
  static const String numberExpected = "Un entier est attendu";
  static const String deletedTicket = "Ticket supprimé";
  static const String addPrize = "Ajouter";
  static const String editPrize = "Modifier";
  static const String openRaffle = "Ouvrir la tombola";
  static const String closeRaffle = "Fermer la tombola";
  static const String openRaffleDescription =
      "Vous allez ouvrir la tombola, les utilisateurs pourront acheter des tickets. Vous ne pourrez plus modifier la tombola. Êtes-vous sûr de vouloir continuer ?";
  static const String closeRaffleDescription =
      "Vous allez fermer la tombola, les utilisateurs ne pourront plus acheter de tickets. Êtes-vous sûr de vouloir continuer ?";
  static const String noCurrentRaffle = "Il n'y a aucune tombola en cours";
  static const String boughtTicket = "Ticket acheté";
  static const String drawingError = "Erreur lors du tirage";
  static const String invalidPrice = "Le prix doit être supérieur à 0";
  static const String mustBePositive =
      "Le nombre doit être strictement positif";
  static const String draw = "Tirer";
  static const String drawn = "Tiré";
  static const String error = "Erreur";
  static const String gathered = "Récolté";
  static const String tickets = "Tickets";
  static const String ticket = "ticket";
  static const String winner = "Gagnant";
  static const String noPrize = "Aucun lot";
  static const String deletePrize = "Supprimer le lot";
  static const String deletePrizeDescription =
      "Vous allez supprimer le lot, êtes-vous sûr de vouloir continuer ?";
  static const String drawing = "Tirage";
  static const String drawingDescription = "Tirer le gagnant du lot ?";
  static const String deleteTicket = "Supprimer le ticket";
  static const String deleteTicketDescription =
      "Vous allez supprimer le ticket, êtes-vous sûr de vouloir continuer ?";
  static const String winningTickets = "Tickets gagnants";
  static const String noWinningTicketYet =
      "Les tickets gagnants seront affichés ici";
  static const String name = "Nom";
  static const String description = "Description";
  static const String buyThisTicket = "Acheter ce ticket";
  static const String lockedRaffle = "Tombola verrouillée";
  static const String unavailableRaffle = "Tombola indisponible";
  static const String notEnoughMoney = "Vous n'avez pas assez d'argent";
  static const String winnable = "gagnable";
  static const String noDescription = "Aucune description";
  static const String amount = "Solde";
  static const String loading = "Chargement";
  static const String ticketNumber = "Nombre de ticket";
  static const String price = "Prix";

  static const String editRaffle = "Modifier la tombola";

  static const String edit = "Modifier";

  static const String addPackTicket = "Ajouter un pack de ticket";
}
