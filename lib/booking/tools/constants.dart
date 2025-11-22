import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingTextConstants {
  static const String add = "Ajouter";
  static const String addBookingPage = "Demande";
  static const String addRoom = "Ajouter une salle";
  static const String addBooking = "Ajouter une réservation";
  static const String addedBooking = "Demande ajoutée";
  static const String addedRoom = "Salle ajoutée";
  static const String addedManager = "Gestionnaire ajouté";
  static const String addingError = "Erreur lors de l'ajout";
  static const String addManager = "Ajouter un gestionnaire";
  static const String adminPage = "Administrateur";
  static const String allDay = "Toute la journée";
  static const String bookedfor = "Réservé pour";
  static const String booking = "Réservation";
  static const String bookingCreated = "Réservation créée";
  static const String bookingDemand = "Demande de réservation";
  static const String bookingNote = "Note de la réservation";
  static const String bookingPage = "Réservation";
  static const String bookingReason = "Motif de la réservation";
  static const String by = "par";
  static const String confirm = "Confirmer";
  static const String confirmation = "Confirmation";
  static const String confirmBooking = "Confirmer la réservation ?";
  static const String confirmed = "Validée";
  static const String dates = "Dates";
  static const String decline = "Refuser";
  static const String declineBooking = "Refuser la réservation ?";
  static const String declined = "Refusée";
  static const String delete = "Supprimer";
  static const String deleting = "Suppression";
  static const String deleteBooking = "Suppression";
  static const String deleteBookingConfirmation =
      "Êtes-vous sûr de vouloir supprimer cette réservation ?";
  static const String deletedBooking = "Réservation supprimée";
  static const String deletedRoom = "Salle supprimée";
  static const String deletedManager = "Gestionnaire supprimé";
  static const String deleteRoomConfirmation =
      "Êtes-vous sûr de vouloir supprimer cette salle ?\n\nLa salle ne doit avoir aucune réservation en cours ou à venir pour être supprimée";
  static const String deleteManagerConfirmation =
      "Êtes-vous sûr de vouloir supprimer ce gestionnaire ?\n\nLe gestionnaire ne doit être associé à aucune salle pour pouvoir être supprimé";
  static const String deletingBooking = "Supprimer la réservation ?";
  static const String deletingError = "Erreur lors de la suppression";
  static const String deletingRoom = "Supprimer la salle ?";
  static const String edit = "Modifier";
  static const String editBooking = "Modifier une réservation";
  static const String editionError = "Erreur lors de la modification";
  static const String editedBooking = "Réservation modifiée";
  static const String editedRoom = "Salle modifiée";
  static const String editedManager = "Gestionnaire modifié";
  static const String editManager = "Modifier ou supprimer un gestionnaire";
  static const String editRoom = "Modifier ou supprimer une salle";
  static const String endDate = "Date de fin";
  static const String endHour = "Heure de fin";
  static const String entity = "Pour qui ?";
  static const String error = "Erreur";
  static const String eventEvery = "Tous les";
  static const String historyPage = "Historique";
  static const String incorrectOrMissingFields =
      "Champs incorrects ou manquants";
  static const String interval = "Intervalle";
  static const String invalidIntervalError = "Intervalle invalide";
  static const String invalidDates = "Dates invalides";
  static const String invalidRoom = "Salle invalide";
  static const String keysRequested = "Clés demandées";
  static const String management = "Gestion";
  static const String manager = "Gestionnaire";
  static const String managerName = "Nom du gestionnaire";
  static const String multipleDay = "Plusieurs jours";
  static const String myBookings = "Mes réservations";
  static const String necessaryKey = "Clé nécessaire";
  static const String next = "Suivant";
  static const String no = "Non";
  static const String noCurrentBooking = "Pas de réservation en cours";
  static const String noDateError = "Veuillez choisir une date";
  static const String noAppointmentInReccurence =
      "Aucun créneau existe avec ces paramètres de récurrence";
  static const String noDaySelected = "Aucun jour sélectionné";
  static const String noDescriptionError = "Veuillez entrer une description";
  static const String noKeys = "Aucune clé";
  static const String noNoteError = "Veuillez entrer une note";
  static const String noPhoneRegistered = "Numéro non renseigné";
  static const String noReasonError = "Veuillez entrer un motif";
  static const String noRoomFoundError = "Aucune salle enregistrée";
  static const String noRoomFound = "Aucune salle trouvée";
  static const String note = "Note";
  static const String other = "Autre";
  static const String pending = "En attente";
  static const String previous = "Précédent";
  static const String reason = "Motif";
  static const String recurrence = "Récurrence";
  static const String recurrenceDays = "Jours de récurrence";
  static const String recurrenceEndDate = "Date de fin de récurrence";
  static const String recurrent = "Récurrent";
  static const String registeredRooms = "Salles enregistrées";
  static const String room = "Salle";
  static const String roomName = "Nom de la salle";
  static const String startDate = "Date de début";
  static const String startHour = "Heure de début";
  static const String weeks = "Semaines";
  static const String yes = "Oui";

  static const List<WeekDays> weekDaysOrdered = [
    WeekDays.monday,
    WeekDays.tuesday,
    WeekDays.wednesday,
    WeekDays.thursday,
    WeekDays.friday,
    WeekDays.saturday,
    WeekDays.sunday,
  ];
}

class BookingPermissionConstants {
  static const String accessBooking = 'access_booking';
  static const String manageManagers = 'manage_managers';
  static const String manageRooms = 'manage_rooms';
}
