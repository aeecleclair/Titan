// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get dateToday => 'Aujourd\'hui';

  @override
  String get dateYesterday => 'Hier';

  @override
  String get dateTomorrow => 'Demain';

  @override
  String get dateAt => 'à';

  @override
  String get dateFrom => 'de';

  @override
  String get dateTo => 'à';

  @override
  String get dateBetweenDays => 'au';

  @override
  String get dateStarting => 'Commence';

  @override
  String get dateLast => '';

  @override
  String get dateUntil => 'Jusqu\'au';

  @override
  String get feedFilterAll => 'Tous';

  @override
  String get feedFilterPending => 'En attente';

  @override
  String get feedFilterApproved => 'Approuvés';

  @override
  String get feedFilterRejected => 'Rejetés';

  @override
  String get feedEmptyAll => 'Aucun événement disponible';

  @override
  String get feedEmptyPending => 'Aucun événement en attente de validation';

  @override
  String get feedEmptyApproved => 'Aucun événement approuvé';

  @override
  String get feedEmptyRejected => 'Aucun événement rejeté';

  @override
  String get feedEventManagement => 'Gestion des événements';

  @override
  String get feedTitle => 'Titre';

  @override
  String get feedLocation => 'Lieu';

  @override
  String get feedSGDate => 'Date du SG';

  @override
  String get feedSGExternalLink => 'Lien externe du SG';

  @override
  String get feedCreateEvent => 'Créer l\'événement';

  @override
  String get feedPleaseSelectAnAssociation =>
      'Veuillez sélectionner une association';

  @override
  String get feedReject => 'Rejeter';

  @override
  String get feedApprove => 'Approuver';

  @override
  String get feedEnded => 'Terminé';

  @override
  String get feedOngoing => 'En cours';

  @override
  String get feedFilter => 'Filtrer';

  @override
  String get feedAssociation => 'Association';

  @override
  String get feedNewsType => 'Type d\'actualité';

  @override
  String get feedApply => 'Appliquer';

  @override
  String get feedNews => 'Actualités';

  @override
  String get feedAdmin => 'Administration';

  @override
  String get feedCreateAnEvent => 'Créer un événement';

  @override
  String get feedManageRequests => 'Demandes de publication';

  @override
  String get feedNoNewsAvailable => 'Aucune actualité disponible';

  @override
  String get feedRefresh => 'Actualiser';

  @override
  String get feedPleaseProvideASGExternalLink =>
      'Veuillez entrer un lien externe pour le SG';

  @override
  String get feedPleaseProvideASGDate => 'Veuillez entrer une date de SG';

  @override
  String feedShotgunIn(String time) {
    return 'Shotgun $time';
  }

  @override
  String feedVoteIn(String time) {
    return 'Vote $time';
  }

  @override
  String get feedCantOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String get feedGetReady => 'Prépare-toi !';

  @override
  String get eventActionCampaign => 'Tu peux voter';

  @override
  String get eventActionEvent => 'Tu es invité';

  @override
  String get eventActionCampaignSubtitle => 'Votez maintenant';

  @override
  String get eventActionEventSubtitle => 'Répondez à l\'invitation';

  @override
  String get eventActionCampaignButton => 'Voter';

  @override
  String get eventActionEventButton => 'Participer';

  @override
  String get eventActionCampaignValidated => 'J\'ai voté !';

  @override
  String get eventActionEventValidated => 'Je viens !';

  @override
  String get adminAccountTypes => 'Types de compte';

  @override
  String get adminAdd => 'Ajouter';

  @override
  String get adminAddGroup => 'Ajouter un groupe';

  @override
  String get adminAddMember => 'Ajouter un membre';

  @override
  String get adminAddedGroup => 'Groupe créé';

  @override
  String get adminAddedLoaner => 'Préteur ajouté';

  @override
  String get adminAddedMember => 'Membre ajouté';

  @override
  String get adminAddingError => 'Erreur lors de l\'ajout';

  @override
  String get adminAddingMember => 'Ajout d\'un membre';

  @override
  String get adminAddLoaningGroup => 'Ajouter un groupe de prêt';

  @override
  String get adminAddSchool => 'Ajouter une école';

  @override
  String get adminAddStructure => 'Ajouter une structure';

  @override
  String get adminAddedSchool => 'École créée';

  @override
  String get adminAddedStructure => 'Structure ajoutée';

  @override
  String get adminEditedStructure => 'Structure modifiée';

  @override
  String get adminAdministration => 'Administration';

  @override
  String get adminAssociationMembership => 'Adhésion';

  @override
  String get adminAssociationMembershipName => 'Nom de l\'adhésion';

  @override
  String get adminAssociationsMemberships => 'Adhésions';

  @override
  String adminBankAccountHolder(String bankAccountHolder) {
    return 'Titulaire du compte bancaire : $bankAccountHolder';
  }

  @override
  String get adminBankAccountHolderModified =>
      'Titulaire du compte bancaire modifié';

  @override
  String get adminBankDetails => 'Coordonnées bancaires';

  @override
  String get adminBic => 'BIC';

  @override
  String get adminBicError => 'Le BIC doit faire 11 caractères';

  @override
  String get adminCity => 'Ville';

  @override
  String get adminClearFilters => 'Effacer les filtres';

  @override
  String get adminCountry => 'Pays';

  @override
  String get adminCreateAssociationMembership => 'Créer une adhésion';

  @override
  String get adminCreatedAssociationMembership => 'Adhésion créée';

  @override
  String get adminCreationError => 'Erreur lors de la création';

  @override
  String get adminDateError =>
      'La date de début doit être avant la date de fin';

  @override
  String get adminDefineAsBankAccountHolder =>
      'Définir comme titulaire du compte bancaire';

  @override
  String get adminDelete => 'Supprimer';

  @override
  String get adminDeleteAssociationMembership => 'Supprimer l\'adhésion ?';

  @override
  String get adminDeletedAssociationMembership => 'Adhésion supprimée';

  @override
  String get adminDeleteGroup => 'Supprimer le groupe';

  @override
  String get adminDeletedGroup => 'Groupe supprimé';

  @override
  String get adminDeleteSchool => 'Supprimer l\'école ?';

  @override
  String get adminDeletedSchool => 'École supprimée';

  @override
  String get adminDeleting => 'Suppression';

  @override
  String get adminDeletingError => 'Erreur lors de la suppression';

  @override
  String get adminDescription => 'Description';

  @override
  String get adminEdit => 'Modifier';

  @override
  String get adminEditStructure => 'Modifier la structure';

  @override
  String get adminEditMembership => 'Modifier l\'adhésion';

  @override
  String get adminEmptyDate => 'Date vide';

  @override
  String get adminEmptyFieldError => 'Le nom ne peut pas être vide';

  @override
  String get adminEmailRegex => 'Email Regex';

  @override
  String get adminEmptyUser => 'Utilisateur vide';

  @override
  String get adminEndDate => 'Date de fin';

  @override
  String get adminEndDateMaximal => 'Date de fin maximale';

  @override
  String get adminEndDateMinimal => 'Date de fin minimale';

  @override
  String get adminError => 'Erreur';

  @override
  String get adminFilters => 'Filtres';

  @override
  String get adminGroup => 'Groupe';

  @override
  String get adminGroups => 'Groupes';

  @override
  String get adminIban => 'IBAN';

  @override
  String get adminIbanError => 'L\'IBAN doit faire 27 caractères';

  @override
  String get adminLoaningGroup => 'Groupe de prêt';

  @override
  String get adminLooking => 'Recherche';

  @override
  String get adminManager => 'Administrateur de la structure';

  @override
  String get adminMaximum => 'Maximum';

  @override
  String get adminMembers => 'Membres';

  @override
  String get adminMembershipAddingError =>
      'Erreur lors de l\'ajout (surement dû à une superposition de dates)';

  @override
  String get adminMemberships => 'Adhésions';

  @override
  String get adminMembershipUpdatingError =>
      'Erreur lors de la modification (surement dû à une superposition de dates)';

  @override
  String get adminMinimum => 'Minimum';

  @override
  String get adminModifyModuleVisibility => 'Visibilité des modules';

  @override
  String get adminName => 'Nom';

  @override
  String get adminNoManager => 'Aucun manager n\'est sélectionné';

  @override
  String get adminNoMember => 'Aucun membre';

  @override
  String get adminNoMoreLoaner => 'Aucun prêteur n\'est disponible';

  @override
  String get adminNoSchool => 'Sans école';

  @override
  String get adminRemoveGroupMember => 'Supprimer le membre du groupe ?';

  @override
  String get adminResearch => 'Recherche';

  @override
  String get adminSchools => 'Écoles';

  @override
  String get adminShortId => 'Short ID (3 lettres)';

  @override
  String get adminShortIdError => 'Le short ID doit faire 3 caractères';

  @override
  String get adminSiegeAddress => 'Adresse du siège';

  @override
  String get adminSiret => 'SIRET';

  @override
  String get adminSiretError => 'SIRET must be 14 digits';

  @override
  String get adminStreet => 'Numéro et rue';

  @override
  String get adminStructures => 'Structures';

  @override
  String get adminStartDate => 'Date de début';

  @override
  String get adminStartDateMaximal => 'Date de début maximale';

  @override
  String get adminStartDateMinimal => 'Date de début minimale';

  @override
  String get adminUndefinedBankAccountHolder =>
      'Titulaire du compte bancaire non défini';

  @override
  String get adminUpdatedAssociationMembership => 'Adhésion modifiée';

  @override
  String get adminUpdatedGroup => 'Groupe modifié';

  @override
  String get adminUpdatedMembership => 'Adhésion modifiée';

  @override
  String get adminUpdatingError => 'Erreur lors de la modification';

  @override
  String get adminUser => 'Utilisateur';

  @override
  String get adminValidateFilters => 'Valider les filtres';

  @override
  String get adminVisibilities => 'Visibilités';

  @override
  String get adminZipcode => 'Code postal';

  @override
  String get adminGroupNotification => 'Notification de groupe';

  @override
  String adminNotifyGroup(String groupName) {
    return 'Notifier le groupe $groupName';
  }

  @override
  String get adminTitle => 'Titre';

  @override
  String get adminContent => 'Contenu';

  @override
  String get adminSend => 'Envoyer';

  @override
  String get adminNotificationSent => 'Notification envoyée';

  @override
  String get adminFailedToSendNotification =>
      'Échec de l\'envoi de la notification';

  @override
  String get adminGroupsManagement => 'Gestion des groupes';

  @override
  String get adminEditGroup => 'Modifier le groupe';

  @override
  String get adminManageMembers => 'Gérer les membres';

  @override
  String get adminDeleteGroupConfirmation =>
      'Êtes-vous sûr de vouloir supprimer ce groupe ?';

  @override
  String get adminFailedToDeleteGroup => 'Échec de la suppression du groupe';

  @override
  String get adminUsersAndGroups => 'Utilisateurs et groupes';

  @override
  String get adminUsersManagement => 'Gestion des utilisateurs';

  @override
  String get adminUsersManagementDescription =>
      'Gérer les utilisateurs de l\'application';

  @override
  String get adminManageUserGroups => 'Gérer les groupes d\'utilisateurs';

  @override
  String get adminSendNotificationToGroup =>
      'Envoyer une notification à un groupe';

  @override
  String get adminPaiementModule => 'Module de paiement';

  @override
  String get adminPaiement => 'Paiement';

  @override
  String get adminManagePaiementStructures =>
      'Gérer les structures du module de paiement';

  @override
  String get adminManageUsersAssociationMemberships =>
      'Gérer les adhésions des utilisateurs';

  @override
  String get adminAssociationMembershipsManagement => 'Gestion des adhésions';

  @override
  String get adminChooseGroupManager => 'Groupe gestionnaire de l\'adhésion';

  @override
  String get adminSelectManager => 'Sélectionner un gestionnaire';

  @override
  String get adminInviteUsers => 'Inviter des utilisateurs';

  @override
  String get adminImportList => 'Importer une liste';

  @override
  String get adminInvitedUsers => 'Utilisateurs invités';

  @override
  String get adminFailedToInviteUsers =>
      'Échec de l\'invitation des utilisateurs';

  @override
  String get adminDeleteUsers => 'Supprimer des utilisateurs';

  @override
  String get adminAdmin => 'Admin';

  @override
  String get adminAssociations => 'Associations';

  @override
  String get adminManageAssociations => 'Gérer les associations';

  @override
  String get adminAddAssociation => 'Ajouter une association';

  @override
  String get adminAssociationName => 'Nom de l\'association';

  @override
  String get adminSelectGroupAssociationManager =>
      'Séléctionner roupe gestionnaire de l\'association';

  @override
  String adminEditAssociation(String associationName) {
    return 'Modifier l\'association : $associationName';
  }

  @override
  String adminManagerGroup(String groupName) {
    return 'Groupe gestionnaire : $groupName';
  }

  @override
  String get adminAssociationCreated => 'Association créée';

  @override
  String get adminAssociationUpdated => 'Association mise à jour';

  @override
  String get adminAssociationCreationError =>
      'Échec de la création de l\'association';

  @override
  String get adminAssociationUpdateError =>
      'Échec de la mise à jour de l\'association';

  @override
  String get adminUpdatedAssociationLogo => 'Logo de l\'association mis à jour';

  @override
  String get adminTooHeavyLogo =>
      'Le logo de l\'association est trop lourd, il doit faire moins de 4 Mo';

  @override
  String get adminFailedToUpdateAssociationLogo =>
      'Échec de la mise à jour du logo de l\'association';

  @override
  String get adminChooseGroup => 'Choisir un groupe';

  @override
  String get adminChooseAssociationManagerGroup =>
      'Choisir un groupe gestionnaire pour l\'association';

  @override
  String get adminConfirm => 'Valider';

  @override
  String get advertAdd => 'Ajouter';

  @override
  String get advertAddedAdvert => 'Annonce publiée';

  @override
  String get advertAddedAnnouncer => 'Annonceur ajouté';

  @override
  String get advertAddingError => 'Erreur lors de l\'ajout';

  @override
  String get advertAdmin => 'Admin';

  @override
  String get advertAdvert => 'Annonce';

  @override
  String get advertChoosingAnnouncer => 'Veuillez choisir un annonceur';

  @override
  String get advertChoosingPoster => 'Veuillez choisir une image';

  @override
  String get advertContent => 'Contenu';

  @override
  String get advertDeleteAdvert => 'Supprimer l\'annonce';

  @override
  String get advertDeleteAnnouncer => 'Supprimer l\'annonceur ?';

  @override
  String get advertDeleting => 'Suppression';

  @override
  String get advertEdit => 'Modifier';

  @override
  String get advertEditedAdvert => 'Annonce modifiée';

  @override
  String get advertEditingError => 'Erreur lors de la modification';

  @override
  String get advertGroupAdvert => 'Groupe';

  @override
  String get advertIncorrectOrMissingFields => 'Champs incorrects ou manquants';

  @override
  String get advertInvalidNumber => 'Veuillez entrer un nombre';

  @override
  String get advertManagement => 'Gestion';

  @override
  String get advertModifyAnnouncingGroup => 'Modifier un groupe d\'annonce';

  @override
  String get advertNoMoreAnnouncer => 'Aucun annonceur n\'est disponible';

  @override
  String get advertNoValue => 'Veuillez entrer une valeur';

  @override
  String get advertPositiveNumber => 'Veuillez entrer un nombre positif';

  @override
  String get advertRemovedAnnouncer => 'Annonceur supprimé';

  @override
  String get advertRemovingError => 'Erreur lors de la suppression';

  @override
  String get advertTags => 'Tags';

  @override
  String get advertTitle => 'Titre';

  @override
  String get advertMonthJan => 'Janv';

  @override
  String get advertMonthFeb => 'Févr.';

  @override
  String get advertMonthMar => 'Mars';

  @override
  String get advertMonthApr => 'Avr.';

  @override
  String get advertMonthMay => 'Mai';

  @override
  String get advertMonthJun => 'Juin';

  @override
  String get advertMonthJul => 'Juill.';

  @override
  String get advertMonthAug => 'Août';

  @override
  String get advertMonthSep => 'Sept.';

  @override
  String get advertMonthOct => 'Oct.';

  @override
  String get advertMonthNov => 'Nov.';

  @override
  String get advertMonthDec => 'Déc.';

  @override
  String get amapAccounts => 'Comptes';

  @override
  String get amapAdd => 'Ajouter';

  @override
  String get amapAddDelivery => 'Ajouter une livraison';

  @override
  String get amapAddedCommand => 'Commande ajoutée';

  @override
  String get amapAddedOrder => 'Commande ajoutée';

  @override
  String get amapAddedProduct => 'Produit ajouté';

  @override
  String get amapAddedUser => 'Utilisateur ajouté';

  @override
  String get amapAddProduct => 'Ajouter un produit';

  @override
  String get amapAddUser => 'Ajouter un utilisateur';

  @override
  String get amapAddingACommand => 'Ajouter une commande';

  @override
  String get amapAddingCommand => 'Ajouter la commande';

  @override
  String get amapAddingError => 'Erreur lors de l\'ajout';

  @override
  String get amapAddingProduct => 'Ajouter un produit';

  @override
  String get amapAddOrder => 'Ajouter une commande';

  @override
  String get amapAdmin => 'Admin';

  @override
  String get amapAlreadyExistCommand =>
      'Il existe déjà une commande à cette date';

  @override
  String get amapAmap => 'Amap';

  @override
  String get amapAmount => 'Solde';

  @override
  String get amapArchive => 'Archiver';

  @override
  String get amapArchiveDelivery => 'Archiver';

  @override
  String get amapArchivingDelivery => 'Archivage de la livraison';

  @override
  String get amapCategory => 'Catégorie';

  @override
  String get amapCloseDelivery => 'Verrouiller';

  @override
  String get amapCommandDate => 'Date de la commande';

  @override
  String get amapCommandProducts => 'Produits de la commande';

  @override
  String get amapConfirm => 'Confirmer';

  @override
  String get amapContact => 'Contacts associatifs ';

  @override
  String get amapCreateCategory => 'Créer une catégorie';

  @override
  String get amapDelete => 'Supprimer';

  @override
  String get amapDeleteDelivery => 'Supprimer la livraison ?';

  @override
  String get amapDeleteDeliveryDescription =>
      'Voulez-vous vraiment supprimer cette livraison ?';

  @override
  String get amapDeletedDelivery => 'Livraison supprimée';

  @override
  String get amapDeletedOrder => 'Commande supprimée';

  @override
  String get amapDeletedProduct => 'Produit supprimé';

  @override
  String get amapDeleteProduct => 'Supprimer le produit ?';

  @override
  String get amapDeleteProductDescription =>
      'Voulez-vous vraiment supprimer ce produit ?';

  @override
  String get amapDeleting => 'Suppression';

  @override
  String get amapDeletingDelivery => 'Supprimer la livraison ?';

  @override
  String get amapDeletingError => 'Erreur lors de la suppression';

  @override
  String get amapDeletingOrder => 'Supprimer la commande ?';

  @override
  String get amapDeletingProduct => 'Supprimer le produit ?';

  @override
  String get amapDeliver => 'Livraison teminée ?';

  @override
  String get amapDeliveries => 'Livraisons';

  @override
  String get amapDeliveringDelivery => 'Toutes les commandes sont livrées ?';

  @override
  String get amapDelivery => 'Livraison';

  @override
  String get amapDeliveryArchived => 'Livraison archivée';

  @override
  String get amapDeliveryDate => 'Date de livraison';

  @override
  String get amapDeliveryDelivered => 'Livraison effectuée';

  @override
  String get amapDeliveryHistory => 'Historique des livraisons';

  @override
  String get amapDeliveryList => 'Liste des livraisons';

  @override
  String get amapDeliveryLocked => 'Livraison verrouillée';

  @override
  String get amapDeliveryOn => 'Livraison le';

  @override
  String get amapDeliveryOpened => 'Livraison ouverte';

  @override
  String get amapDeliveryNotArchived => 'Livraison non archivée';

  @override
  String get amapDeliveryNotLocked => 'Livraison non verrouillée';

  @override
  String get amapDeliveryNotDelivered => 'Livraison non effectuée';

  @override
  String get amapDeliveryNotOpened => 'Livraison non ouverte';

  @override
  String get amapEditDelivery => 'Modifier la livraison';

  @override
  String get amapEditedCommand => 'Commande modifiée';

  @override
  String get amapEditingError => 'Erreur lors de la modification';

  @override
  String get amapEditProduct => 'Modifier le produit';

  @override
  String get amapEndingDelivery => 'Fin de la livraison';

  @override
  String get amapError => 'Erreur';

  @override
  String get amapErrorLink => 'Erreur lors de l\'ouverture du lien';

  @override
  String get amapErrorLoadingUser =>
      'Erreur lors du chargement des utilisateurs';

  @override
  String get amapEvening => 'Soir';

  @override
  String get amapExpectingNumber => 'Veuillez entrer un nombre';

  @override
  String get amapFillField => 'Veuillez remplir ce champ';

  @override
  String get amapHandlingAccount => 'Gérer les comptes';

  @override
  String get amapLoading => 'Chargement...';

  @override
  String get amapLoadingError => 'Erreur lors du chargement';

  @override
  String get amapLock => 'Verrouiller';

  @override
  String get amapLocked => 'Verrouillée';

  @override
  String get amapLockedDelivery => 'Livraison verrouillée';

  @override
  String get amapLockedOrder => 'Commande verrouillée';

  @override
  String get amapLooking => 'Rechercher';

  @override
  String get amapLockingDelivery => 'Verrouiller la livraison ?';

  @override
  String get amapMidDay => 'Midi';

  @override
  String get amapMyOrders => 'Mes commandes';

  @override
  String get amapName => 'Nom';

  @override
  String get amapNextStep => 'Étape suivante';

  @override
  String get amapNoProduct => 'Pas de produit';

  @override
  String get amapNoCurrentOrder => 'Pas de commande en cours';

  @override
  String get amapNoMoney => 'Pas assez d\'argent';

  @override
  String get amapNoOpennedDelivery => 'Pas de livraison ouverte';

  @override
  String get amapNoOrder => 'Pas de commande';

  @override
  String get amapNoSelectedDelivery => 'Pas de livraison sélectionnée';

  @override
  String get amapNotEnoughMoney => 'Pas assez d\'argent';

  @override
  String get amapNotPlannedDelivery => 'Pas de livraison planifiée';

  @override
  String get amapOneOrder => 'commande';

  @override
  String get amapOpenDelivery => 'Ouvrir';

  @override
  String get amapOpened => 'Ouverte';

  @override
  String get amapOpenningDelivery => 'Ouvrir la livraison ?';

  @override
  String get amapOrder => 'Commander';

  @override
  String get amapOrders => 'Commandes';

  @override
  String get amapPickChooseCategory =>
      'Veuillez entrer une valeur ou choisir une catégorie existante';

  @override
  String get amapPickDeliveryMoment => 'Choisissez un moment de livraison';

  @override
  String get amapPresentation => 'Présentation';

  @override
  String get amapPresentation1 =>
      'L\'AMAP (association pour le maintien d\'une agriculture paysanne) est un service proposé par l\'association Planet&Co de l\'ECL. Vous pouvez ainsi recevoir des produits (paniers de fruits et légumes, jus, confitures...) directement sur le campus !\n\nLes commandes doivent être passées avant le vendredi 21h et sont livrées sur le campus le mardi de 13h à 13h45 (ou de 18h15 à 18h30 si vous ne pouvez pas passer le midi) dans le hall du M16.\n\nVous ne pouvez commander que si votre solde le permet. Vous pouvez recharger votre solde via la collecte Lydia ou bien avec un chèque que vous pouvez nous transmettre lors des permanences.\n\nLien vers la collecte Lydia pour le rechargement : ';

  @override
  String get amapPresentation2 =>
      '\n\nN\'hésitez pas à nous contacter en cas de problème !';

  @override
  String get amapPrice => 'Prix';

  @override
  String get amapProduct => 'produit';

  @override
  String get amapProducts => 'Produits';

  @override
  String get amapProductInDelivery => 'Produit dans une livraison non terminée';

  @override
  String get amapQuantity => 'Quantité';

  @override
  String get amapRequiredDate => 'La date est requise';

  @override
  String get amapSeeMore => 'Voir plus';

  @override
  String get amapThe => 'Le';

  @override
  String get amapUnlock => 'Dévérouiller';

  @override
  String get amapUnlockedDelivery => 'Livraison dévérouillée';

  @override
  String get amapUnlockingDelivery => 'Dévérouiller la livraison ?';

  @override
  String get amapUpdate => 'Modifier';

  @override
  String get amapUpdatedAmount => 'Solde modifié';

  @override
  String get amapUpdatedOrder => 'Commande modifiée';

  @override
  String get amapUpdatedProduct => 'Produit modifié';

  @override
  String get amapUpdatingError => 'Echec de la modification';

  @override
  String get amapUsersNotFound => 'Aucun utilisateur trouvé';

  @override
  String get amapWaiting => 'En attente';

  @override
  String get bookingAdd => 'Ajouter';

  @override
  String get bookingAddBookingPage => 'Demande';

  @override
  String get bookingAddRoom => 'Ajouter une salle';

  @override
  String get bookingAddBooking => 'Ajouter une réservation';

  @override
  String get bookingAddedBooking => 'Demande ajoutée';

  @override
  String get bookingAddedRoom => 'Salle ajoutée';

  @override
  String get bookingAddedManager => 'Gestionnaire ajouté';

  @override
  String get bookingAddingError => 'Erreur lors de l\'ajout';

  @override
  String get bookingAddManager => 'Ajouter un gestionnaire';

  @override
  String get bookingAdminPage => 'Administrateur';

  @override
  String get bookingAllDay => 'Toute la journée';

  @override
  String get bookingBookedFor => 'Réservé pour';

  @override
  String get bookingBooking => 'Réservation';

  @override
  String get bookingBookingCreated => 'Réservation créée';

  @override
  String get bookingBookingDemand => 'Demande de réservation';

  @override
  String get bookingBookingNote => 'Note de la réservation';

  @override
  String get bookingBookingPage => 'Réservation';

  @override
  String get bookingBookingReason => 'Motif de la réservation';

  @override
  String get bookingBy => 'par';

  @override
  String get bookingConfirm => 'Confirmer';

  @override
  String get bookingConfirmation => 'Confirmation';

  @override
  String get bookingConfirmBooking => 'Confirmer la réservation ?';

  @override
  String get bookingConfirmed => 'Validée';

  @override
  String get bookingDates => 'Dates';

  @override
  String get bookingDecline => 'Refuser';

  @override
  String get bookingDeclineBooking => 'Refuser la réservation ?';

  @override
  String get bookingDeclined => 'Refusée';

  @override
  String get bookingDelete => 'Supprimer';

  @override
  String get bookingDeleting => 'Suppression';

  @override
  String get bookingDeleteBooking => 'Suppression';

  @override
  String get bookingDeleteBookingConfirmation =>
      'Êtes-vous sûr de vouloir supprimer cette réservation ?';

  @override
  String get bookingDeletedBooking => 'Réservation supprimée';

  @override
  String get bookingDeletedRoom => 'Salle supprimée';

  @override
  String get bookingDeletedManager => 'Gestionnaire supprimé';

  @override
  String get bookingDeleteRoomConfirmation =>
      'Êtes-vous sûr de vouloir supprimer cette salle ?\n\nLa salle ne doit avoir aucune réservation en cours ou à venir pour être supprimée';

  @override
  String get bookingDeleteManagerConfirmation =>
      'Êtes-vous sûr de vouloir supprimer ce gestionnaire ?\n\nLe gestionnaire ne doit être associé à aucune salle pour pouvoir être supprimé';

  @override
  String get bookingDeletingBooking => 'Supprimer la réservation ?';

  @override
  String get bookingDeletingError => 'Erreur lors de la suppression';

  @override
  String get bookingDeletingRoom => 'Supprimer la salle ?';

  @override
  String get bookingEdit => 'Modifier';

  @override
  String get bookingEditBooking => 'Modifier une réservation';

  @override
  String get bookingEditionError => 'Erreur lors de la modification';

  @override
  String get bookingEditedBooking => 'Réservation modifiée';

  @override
  String get bookingEditedRoom => 'Salle modifiée';

  @override
  String get bookingEditedManager => 'Gestionnaire modifié';

  @override
  String get bookingEditManager => 'Modifier ou supprimer un gestionnaire';

  @override
  String get bookingEditRoom => 'Modifier ou supprimer une salle';

  @override
  String get bookingEndDate => 'Date de fin';

  @override
  String get bookingEndHour => 'Heure de fin';

  @override
  String get bookingEntity => 'Pour qui ?';

  @override
  String get bookingError => 'Erreur';

  @override
  String get bookingEventEvery => 'Tous les';

  @override
  String get bookingHistoryPage => 'Historique';

  @override
  String get bookingIncorrectOrMissingFields =>
      'Champs incorrects ou manquants';

  @override
  String get bookingInterval => 'Intervalle';

  @override
  String get bookingInvalidIntervalError => 'Intervalle invalide';

  @override
  String get bookingInvalidDates => 'Dates invalides';

  @override
  String get bookingInvalidRoom => 'Salle invalide';

  @override
  String get bookingKeysRequested => 'Clés demandées';

  @override
  String get bookingManagement => 'Gestion';

  @override
  String get bookingManager => 'Gestionnaire';

  @override
  String get bookingManagerName => 'Nom du gestionnaire';

  @override
  String get bookingMultipleDay => 'Plusieurs jours';

  @override
  String get bookingMyBookings => 'Mes réservations';

  @override
  String get bookingNecessaryKey => 'Clé nécessaire';

  @override
  String get bookingNext => 'Suivant';

  @override
  String get bookingNo => 'Non';

  @override
  String get bookingNoCurrentBooking => 'Pas de réservation en cours';

  @override
  String get bookingNoDateError => 'Veuillez choisir une date';

  @override
  String get bookingNoAppointmentInReccurence =>
      'Aucun créneau existe avec ces paramètres de récurrence';

  @override
  String get bookingNoDaySelected => 'Aucun jour sélectionné';

  @override
  String get bookingNoDescriptionError => 'Veuillez entrer une description';

  @override
  String get bookingNoKeys => 'Aucune clé';

  @override
  String get bookingNoNoteError => 'Veuillez entrer une note';

  @override
  String get bookingNoPhoneRegistered => 'Numéro non renseigné';

  @override
  String get bookingNoReasonError => 'Veuillez entrer un motif';

  @override
  String get bookingNoRoomFoundError => 'Aucune salle enregistrée';

  @override
  String get bookingNoRoomFound => 'Aucune salle trouvée';

  @override
  String get bookingNote => 'Note';

  @override
  String get bookingOther => 'Autre';

  @override
  String get bookingPending => 'En attente';

  @override
  String get bookingPrevious => 'Précédent';

  @override
  String get bookingReason => 'Motif';

  @override
  String get bookingRecurrence => 'Récurrence';

  @override
  String get bookingRecurrenceDays => 'Jours de récurrence';

  @override
  String get bookingRecurrenceEndDate => 'Date de fin de récurrence';

  @override
  String get bookingRecurrent => 'Récurrent';

  @override
  String get bookingRegisteredRooms => 'Salles enregistrées';

  @override
  String get bookingRoom => 'Salle';

  @override
  String get bookingRoomName => 'Nom de la salle';

  @override
  String get bookingStartDate => 'Date de début';

  @override
  String get bookingStartHour => 'Heure de début';

  @override
  String get bookingWeeks => 'Semaines';

  @override
  String get bookingYes => 'Oui';

  @override
  String get bookingWeekDayMon => 'Lundi';

  @override
  String get bookingWeekDayTue => 'Mardi';

  @override
  String get bookingWeekDayWed => 'Mercredi';

  @override
  String get bookingWeekDayThu => 'Jeudi';

  @override
  String get bookingWeekDayFri => 'Vendredi';

  @override
  String get bookingWeekDaySat => 'Samedi';

  @override
  String get bookingWeekDaySun => 'Dimanche';

  @override
  String get cinemaAdd => 'Ajouter';

  @override
  String get cinemaAddedSession => 'Séance ajoutée';

  @override
  String get cinemaAddingError => 'Erreur lors de l\'ajout';

  @override
  String get cinemaAddSession => 'Ajouter une séance';

  @override
  String get cinemaCinema => 'Cinéma';

  @override
  String get cinemaDeleteSession => 'Supprimer la séance ?';

  @override
  String get cinemaDeleting => 'Suppression';

  @override
  String get cinemaDuration => 'Durée';

  @override
  String get cinemaEdit => 'Modifier';

  @override
  String get cinemaEditedSession => 'Séance modifiée';

  @override
  String get cinemaEditingError => 'Erreur lors de la modification';

  @override
  String get cinemaEditSession => 'Modifier la séance';

  @override
  String get cinemaEmptyUrl => 'Veuillez entrer une URL';

  @override
  String get cinemaImportFromTMDB => 'Importer depuis TMDB';

  @override
  String get cinemaIncomingSession => 'A l\'affiche';

  @override
  String get cinemaIncorrectOrMissingFields => 'Champs incorrects ou manquants';

  @override
  String get cinemaInvalidUrl => 'URL invalide';

  @override
  String get cinemaGenre => 'Genre';

  @override
  String get cinemaName => 'Nom';

  @override
  String get cinemaNoDateError => 'Veuillez entrer une date';

  @override
  String get cinemaNoDuration => 'Veuillez entrer une durée';

  @override
  String get cinemaNoOverview => 'Aucun synopsis';

  @override
  String get cinemaNoPoster => 'Aucune affiche';

  @override
  String get cinemaNoSession => 'Aucune séance';

  @override
  String get cinemaOverview => 'Synopsis';

  @override
  String get cinemaPosterUrl => 'URL de l\'affiche';

  @override
  String get cinemaSessionDate => 'Jour de la séance';

  @override
  String get cinemaStartHour => 'Heure de début';

  @override
  String get cinemaTagline => 'Slogan';

  @override
  String get cinemaThe => 'Le';

  @override
  String get drawerAdmin => 'Administration';

  @override
  String get drawerAndroidAppLink =>
      'https://play.google.com/store/apps/details?id=fr.myecl.titan';

  @override
  String get drawerCopied => 'Copié !';

  @override
  String get drawerDownloadAppOnMobileDevice =>
      'Ce site est la version Web de l\'application MyECL. Nous vous invitons à télécharger l\'application. N\'utilisez ce site qu\'en cas de problème avec l\'application.\n';

  @override
  String get drawerIosAppLink =>
      'https://apps.apple.com/fr/app/myecl/id6444443430';

  @override
  String get drawerLoginOut => 'Voulez-vous vous déconnecter ?';

  @override
  String get drawerLogOut => 'Déconnexion';

  @override
  String get drawerOr => ' ou ';

  @override
  String get drawerSettings => 'Paramètres';

  @override
  String get eventAdd => 'Ajouter';

  @override
  String get eventAddEvent => 'Ajouter un événement';

  @override
  String get eventAddedEvent => 'Événement ajouté';

  @override
  String get eventAddingError => 'Erreur lors de l\'ajout';

  @override
  String get eventAllDay => 'Toute la journée';

  @override
  String get eventConfirm => 'Confirmer';

  @override
  String get eventConfirmEvent => 'Confirmer l\'événement ?';

  @override
  String get eventConfirmation => 'Confirmation';

  @override
  String get eventConfirmed => 'Confirmé';

  @override
  String get eventDates => 'Dates';

  @override
  String get eventDecline => 'Refuser';

  @override
  String get eventDeclineEvent => 'Refuser l\'événement ?';

  @override
  String get eventDeclined => 'Refusé';

  @override
  String get eventDelete => 'Supprimer';

  @override
  String get eventDeletedEvent => 'Événement supprimé';

  @override
  String get eventDeleting => 'Suppression';

  @override
  String get eventDeletingError => 'Erreur lors de la suppression';

  @override
  String get eventDeletingEvent => 'Supprimer l\'événement ?';

  @override
  String get eventDescription => 'Description';

  @override
  String get eventEdit => 'Modifier';

  @override
  String get eventEditEvent => 'Modifier un événement';

  @override
  String get eventEditedEvent => 'Événement modifié';

  @override
  String get eventEditingError => 'Erreur lors de la modification';

  @override
  String get eventEndDate => 'Date de fin';

  @override
  String get eventEndHour => 'Heure de fin';

  @override
  String get eventError => 'Erreur';

  @override
  String get eventEventList => 'Liste des événements';

  @override
  String get eventEventType => 'Type d\'événement';

  @override
  String get eventEvery => 'Tous les';

  @override
  String get eventHistory => 'Historique';

  @override
  String get eventIncorrectOrMissingFields =>
      'Certains champs sont incorrects ou manquants';

  @override
  String get eventInterval => 'Intervalle';

  @override
  String get eventInvalidDates =>
      'La date de fin doit être après la date de début';

  @override
  String get eventInvalidIntervalError =>
      'Veuillez entrer un intervalle valide';

  @override
  String get eventLocation => 'Lieu';

  @override
  String get eventMyEvents => 'Mes événements';

  @override
  String get eventName => 'Nom';

  @override
  String get eventNext => 'Suivant';

  @override
  String get eventNo => 'Non';

  @override
  String get eventNoCurrentEvent => 'Aucun événement en cours';

  @override
  String get eventNoDateError => 'Veuillez entrer une date';

  @override
  String get eventNoDaySelected => 'Aucun jour sélectionné';

  @override
  String get eventNoDescriptionError => 'Veuillez entrer une description';

  @override
  String get eventNoEvent => 'Aucun événement';

  @override
  String get eventNoNameError => 'Veuillez entrer un nom';

  @override
  String get eventNoOrganizerError => 'Veuillez entrer un organisateur';

  @override
  String get eventNoPlaceError => 'Veuillez entrer un lieu';

  @override
  String get eventNoPhoneRegistered => 'Numéro non renseigné';

  @override
  String get eventNoRuleError => 'Veuillez entrer une règle de récurrence';

  @override
  String get eventOrganizer => 'Organisateur';

  @override
  String get eventOther => 'Autre';

  @override
  String get eventPending => 'En attente';

  @override
  String get eventPrevious => 'Précédent';

  @override
  String get eventRecurrence => 'Récurrence';

  @override
  String get eventRecurrenceDays => 'Jours de récurrence';

  @override
  String get eventRecurrenceEndDate => 'Date de fin de la récurrence';

  @override
  String get eventRecurrenceRule => 'Règle de récurrence';

  @override
  String get eventRoom => 'Salle';

  @override
  String get eventStartDate => 'Date de début';

  @override
  String get eventStartHour => 'Heure de début';

  @override
  String get eventTitle => 'Événements';

  @override
  String get eventYes => 'Oui';

  @override
  String get eventEventEvery => 'Toutes les';

  @override
  String get eventWeeks => 'semaines';

  @override
  String get eventDayMon => 'Lundi';

  @override
  String get eventDayTue => 'Mardi';

  @override
  String get eventDayWed => 'Mercredi';

  @override
  String get eventDayThu => 'Jeudi';

  @override
  String get eventDayFri => 'Vendredi';

  @override
  String get eventDaySat => 'Samedi';

  @override
  String get eventDaySun => 'Dimanche';

  @override
  String get globalConfirm => 'Confirmer';

  @override
  String get globalCancel => 'Annuler';

  @override
  String get globalIrreversibleAction => 'Cette action est irréversible';

  @override
  String globalOptionnal(String text) {
    return '$text (Optionnel)';
  }

  @override
  String get homeCalendar => 'Calendrier';

  @override
  String get homeEventOf => 'Évènements du';

  @override
  String get homeIncomingEvents => 'Évènements à venir';

  @override
  String get homeLastInfos => 'Dernières annonces';

  @override
  String get homeNoEvents => 'Aucun évènement';

  @override
  String get homeTranslateDayShortMon => 'Lun';

  @override
  String get homeTranslateDayShortTue => 'Mar';

  @override
  String get homeTranslateDayShortWed => 'Mer';

  @override
  String get homeTranslateDayShortThu => 'Jeu';

  @override
  String get homeTranslateDayShortFri => 'Ven';

  @override
  String get homeTranslateDayShortSat => 'Sam';

  @override
  String get homeTranslateDayShortSun => 'Dim';

  @override
  String get loanAdd => 'Ajouter';

  @override
  String get loanAddLoan => 'Ajouter un prêt';

  @override
  String get loanAddObject => 'Ajouter un objet';

  @override
  String get loanAddedLoan => 'Prêt ajouté';

  @override
  String get loanAddedObject => 'Objet ajouté';

  @override
  String get loanAddedRoom => 'Salle ajoutée';

  @override
  String get loanAddingError => 'Erreur lors de l\'ajout';

  @override
  String get loanAdmin => 'Administrateur';

  @override
  String get loanAvailable => 'Disponible';

  @override
  String get loanAvailableMultiple => 'Disponibles';

  @override
  String get loanBorrowed => 'Emprunté';

  @override
  String get loanBorrowedMultiple => 'Empruntés';

  @override
  String get loanAnd => 'et';

  @override
  String get loanAssociation => 'Association';

  @override
  String get loanAvailableItems => 'Objets disponibles';

  @override
  String get loanBeginDate => 'Date du début du prêt';

  @override
  String get loanBorrower => 'Emprunteur';

  @override
  String get loanCaution => 'Caution';

  @override
  String get loanCancel => 'Annuler';

  @override
  String get loanConfirm => 'Confirmer';

  @override
  String get loanConfirmation => 'Confirmation';

  @override
  String get loanDates => 'Dates';

  @override
  String get loanDays => 'Jours';

  @override
  String get loanDelay => 'Délai de la prolongation';

  @override
  String get loanDelete => 'Supprimer';

  @override
  String get loanDeletingLoan => 'Supprimer le prêt ?';

  @override
  String get loanDeletedItem => 'Objet supprimé';

  @override
  String get loanDeletedLoan => 'Prêt supprimé';

  @override
  String get loanDeleting => 'Suppression';

  @override
  String get loanDeletingError => 'Erreur lors de la suppression';

  @override
  String get loanDeletingItem => 'Supprimer l\'objet ?';

  @override
  String get loanDuration => 'Durée';

  @override
  String get loanEdit => 'Modifier';

  @override
  String get loanEditItem => 'Modifier l\'objet';

  @override
  String get loanEditLoan => 'Modifier le prêt';

  @override
  String get loanEditedRoom => 'Salle modifiée';

  @override
  String get loanEndDate => 'Date de fin du prêt';

  @override
  String get loanEnded => 'Terminé';

  @override
  String get loanEnterDate => 'Veuillez entrer une date';

  @override
  String get loanExtendedLoan => 'Prêt prolongé';

  @override
  String get loanExtendingError => 'Erreur lors de la prolongation';

  @override
  String get loanHistory => 'Historique';

  @override
  String get loanIncorrectOrMissingFields =>
      'Des champs sont manquants ou incorrects';

  @override
  String get loanInvalidNumber => 'Veuillez entrer un nombre';

  @override
  String get loanInvalidDates => 'Les dates ne sont pas valides';

  @override
  String get loanItem => 'Objet';

  @override
  String get loanItems => 'Objets';

  @override
  String get loanItemHandling => 'Gestion des objets';

  @override
  String get loanItemSelected => 'objet sélectionné';

  @override
  String get loanItemsSelected => 'objets sélectionnés';

  @override
  String get loanLendingDuration => 'Durée possible du prêt';

  @override
  String get loanLoan => 'Prêt';

  @override
  String get loanLoanHandling => 'Gestion des prêts';

  @override
  String get loanLooking => 'Rechercher';

  @override
  String get loanName => 'Nom';

  @override
  String get loanNext => 'Suivant';

  @override
  String get loanNo => 'Non';

  @override
  String get loanNoAssociationsFounded => 'Aucune association trouvée';

  @override
  String get loanNoAvailableItems => 'Aucun objet disponible';

  @override
  String get loanNoBorrower => 'Aucun emprunteur';

  @override
  String get loanNoItems => 'Aucun objet';

  @override
  String get loanNoItemSelected => 'Aucun objet sélectionné';

  @override
  String get loanNoLoan => 'Aucun prêt';

  @override
  String get loanNoReturnedDate => 'Pas de date de retour';

  @override
  String get loanQuantity => 'Quantité';

  @override
  String get loanNone => 'Aucun';

  @override
  String get loanNote => 'Note';

  @override
  String get loanNoValue => 'Veuillez entrer une valeur';

  @override
  String get loanOnGoing => 'En cours';

  @override
  String get loanOnGoingLoan => 'Prêt en cours';

  @override
  String get loanOthers => 'autres';

  @override
  String get loanPaidCaution => 'Caution payée';

  @override
  String get loanPositiveNumber => 'Veuillez entrer un nombre positif';

  @override
  String get loanPrevious => 'Précédent';

  @override
  String get loanReturned => 'Rendu';

  @override
  String get loanReturnedLoan => 'Prêt rendu';

  @override
  String get loanReturningError => 'Erreur lors du retour';

  @override
  String get loanReturningLoan => 'Retour';

  @override
  String get loanReturnLoan => 'Rendre le prêt ?';

  @override
  String get loanReturnLoanDescription => 'Voulez-vous rendre ce prêt ?';

  @override
  String get loanToReturn => 'A rendre';

  @override
  String get loanUnavailable => 'Indisponible';

  @override
  String get loanUpdate => 'Modifier';

  @override
  String get loanUpdatedItem => 'Objet modifié';

  @override
  String get loanUpdatedLoan => 'Prêt modifié';

  @override
  String get loanUpdatingError => 'Erreur lors de la modification';

  @override
  String get loanYes => 'Oui';

  @override
  String get loginAccountActivated => 'Compte activé';

  @override
  String get loginAccountNotActivated => 'Compte non activé';

  @override
  String get loginActivationCode => 'Code d\'activation';

  @override
  String get loginBirthday => 'Date de naissance';

  @override
  String get loginCanBeEmpty => 'Ce champ peut être vide';

  @override
  String get loginConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get loginCreate => 'Créer';

  @override
  String get loginCreateAccount => 'Créer un compte';

  @override
  String get loginCreateAccountTitle => 'Créer un\ncompte';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginEmailEmpty => 'Veuillez entrer une adresse mail';

  @override
  String get loginEmailInvalid =>
      'Veuillez entrer une adresse mail de centrale.\nSi vous n\'en possédez pas, veuillez contacter Éclair';

  @override
  String get loginEmptyFieldError => 'Ce champ ne peut pas être vide';

  @override
  String get loginEndActivation => 'Finaliser l\'activation';

  @override
  String get loginEndResetPassword => 'Finaliser la \nréinitialisation';

  @override
  String get loginErrorResetPassword => 'Erreur lors de la réinitialisation';

  @override
  String get loginExpectingDate => 'Une date est attendue';

  @override
  String get loginFillAllFields => 'Veuillez remplir tous les champs';

  @override
  String get loginFirstname => 'Prénom';

  @override
  String get loginFloor => 'Étage';

  @override
  String get loginForgetPassword => 'Mot de passe\noublié';

  @override
  String get loginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginInvalidToken => 'Code d\'activation invalide';

  @override
  String get loginLoginFailed => 'Échec de la connexion';

  @override
  String get loginMailSendingError => 'Erreur lors de la création du compte';

  @override
  String get loginMustBeIntError => 'Ce champ doit être un entier';

  @override
  String get loginName => 'Nom';

  @override
  String get loginNewPassword => 'Nouveau mot de passe';

  @override
  String get loginPassword => 'Mot de passe';

  @override
  String get loginPasswordLengthError =>
      'Le mot de passe doit faire au moins 6 caractères';

  @override
  String get loginPasswordUppercaseError =>
      'Le mot de passe doit contenir au moins une majuscule';

  @override
  String get loginPasswordLowercaseError =>
      'Le mot de passe doit contenir au moins une minucule';

  @override
  String get loginPasswordNumberError =>
      'Le mot de passe doit contenir au moins un chiffre';

  @override
  String get loginPasswordSpecialCaracterError =>
      'Le mot de passe doit contenir au moins un caractère spécial';

  @override
  String get loginPasswordMustMatch => 'Les mots de passe doivent correspondre';

  @override
  String get loginPasswordStrengthVeryWeak => 'Très faible';

  @override
  String get loginPasswordStrengthWeak => 'Faible';

  @override
  String get loginPasswordStrengthMedium => 'Moyen';

  @override
  String get loginPasswordStrengthStrong => 'Fort';

  @override
  String get loginPasswordStrengthVeryStrong => 'Très fort';

  @override
  String get loginPhone => 'Téléphone';

  @override
  String get loginPromo => 'Promo entrante (ex : 2023)';

  @override
  String get loginSendedMail => 'Mail de confirmation envoyé';

  @override
  String get loginSendedResetMail => 'Mail de réinitialisation envoyé';

  @override
  String get loginSignIn => 'Se connecter';

  @override
  String get loginRegister => 'S\'inscrire';

  @override
  String get loginRecievedMail => 'J\'ai reçu le mail';

  @override
  String get loginRecover => 'Réinitialiser';

  @override
  String get loginResetedPassword => 'Mot de passe réinitialisé';

  @override
  String get loginResetPasswordTitle => 'Réinitialiser\nle mot de \npasse';

  @override
  String get loginNickname => 'Surnom';

  @override
  String get loginWelcomeBack => 'Bienvenue';

  @override
  String get loginAppName => 'MyECL';

  @override
  String get othersCheckInternetConnection =>
      'Veuillez vérifier votre connexion internet';

  @override
  String get othersRetry => 'Réessayer';

  @override
  String get othersTooOldVersion =>
      'Votre version de l\'application est trop ancienne.\n\nVeuillez mettre à jour l\'application.';

  @override
  String get othersUnableToConnectToServer =>
      'Impossible de se connecter au serveur';

  @override
  String get othersVersion => 'Version';

  @override
  String get othersNoModule =>
      'Aucun module disponible, veuillez réessayer ultérieurement 😢😢';

  @override
  String get othersAdmin => 'Admin';

  @override
  String get othersError => 'Une erreur est survenue';

  @override
  String get othersNoValue => 'Veuillez entrer une valeur';

  @override
  String get othersInvalidNumber => 'Veuillez entrer un nombre';

  @override
  String get othersNoDateError => 'Veuillez entrer une date';

  @override
  String get othersImageSizeTooBig =>
      'La taille de l\'image ne doit pas dépasser 4 Mio';

  @override
  String get othersImageError => 'Erreur lors de l\'ajout de l\'image';

  @override
  String get paiementAccept => 'Accepter';

  @override
  String get paiementAccessPage => 'Accéder à la page';

  @override
  String get paiementAdd => 'Ajouter';

  @override
  String get paiementAddedSeller => 'Vendeur ajouté';

  @override
  String get paiementAddingSellerError => 'Erreur lors de l\'ajout du vendeur';

  @override
  String get paiementAddingStoreError => 'Erreur lors de l\'ajout du magasin';

  @override
  String get paiementAddSeller => 'Ajouter un vendeur';

  @override
  String get paiementAddStore => 'Ajouter un magasin';

  @override
  String get paiementAddThisDevice => 'Ajouter cet appareil';

  @override
  String get paiementAdmin => 'Administrateur';

  @override
  String get paiementAmount => 'Montant';

  @override
  String get paiementAskDeviceActivation =>
      'Demande d\'activation de l\'appareil';

  @override
  String get paiementAStore => 'un magasin';

  @override
  String get paiementAt => 'à';

  @override
  String get paiementAuthenticationRequired =>
      'Authentification requise pour payer';

  @override
  String get paiementAuthentificationFailed => 'Échec de l\'authentification';

  @override
  String get paiementBalanceAfterTopUp => 'Solde après recharge :';

  @override
  String get paiementBalanceAfterTransaction => 'Solde après paiement : ';

  @override
  String get paiementBank => 'Encaisser';

  @override
  String get paiementBillingSpace => 'Espace facturation';

  @override
  String get paiementCameraPermissionRequired =>
      'Permission d\'accès à la caméra requise';

  @override
  String get paiementCameraPerssionRequiredDescription =>
      'Pour scanner un QR Code, vous devez autoriser l\'accès à la caméra.';

  @override
  String get paiementCanBank => 'Peut encaisser';

  @override
  String get paiementCanCancelTransaction => 'Peut annuler des transactions';

  @override
  String get paiementCancel => 'Annuler';

  @override
  String get paiementCancelled => 'Annulé';

  @override
  String get paiementCancelledTransaction => 'Paiement annulé';

  @override
  String get paiementCancelTransaction => 'Annuler la transaction';

  @override
  String get paiementCancelTransactions => 'Annuler les transactions';

  @override
  String get paiementCanManageSellers => 'Peut gérer les vendeurs';

  @override
  String get paiementCanSeeHistory => 'Peut voir l\'historique';

  @override
  String get paiementClose => 'Fermer';

  @override
  String get paiementCreate => 'Créer';

  @override
  String get paiementCreateInvoice => 'Créer une facture';

  @override
  String get paiementDecline => 'Refuser';

  @override
  String get paiementDeletedSeller => 'Vendeur supprimé';

  @override
  String get paiementDeleteInvoice => 'Supprimer la facture';

  @override
  String get paiementDeleteSeller => 'Supprimer le vendeur';

  @override
  String get paiementDeleteSellerDescription =>
      'Voulez-vous vraiment supprimer ce vendeur ?';

  @override
  String get paiementDeleteSuccessfully => 'Supprimé avec succès';

  @override
  String get paiementDeleteStore => 'Supprimer le magasin';

  @override
  String get paiementDeleteStoreDescription =>
      'Voulez-vous vraiment supprimer ce magasin ?';

  @override
  String get paiementDeleteStoreError => 'Impossible de supprimer le magasin';

  @override
  String get paiementDeletingSellerError =>
      'Erreur lors de la suppression du vendeur';

  @override
  String get paiementDeviceActivationReceived =>
      'La demande d\'activation est prise en compte, veuilliez consulter votre boite mail pour finaliser la démarche';

  @override
  String get paiementDeviceNotActivated => 'Appareil non activé';

  @override
  String get paiementDeviceNotActivatedDescription =>
      'Votre appareil n\'est pas encore activé. \nPour l\'activer, veuillez vous rendre sur la page des appareils.';

  @override
  String get paiementDeviceNotRegistered => 'Appareil non enregistré';

  @override
  String get paiementDeviceNotRegisteredDescription =>
      'Votre appareil n\'est pas encore enregistré. \nPour l\'enregistrer, veuillez vous rendre sur la page des appareils.';

  @override
  String get paiementDeviceRecoveryError =>
      'Erreur lors de la récupération de l\'appareil';

  @override
  String get paiementDeviceRevoked => 'Appareil révoqué';

  @override
  String get paiementDeviceRevokingError =>
      'Erreur lors de la révocation de l\'appareil';

  @override
  String get paiementDevices => 'Appareils';

  @override
  String get paiementDoneTransaction => 'Transaction effectuée';

  @override
  String get paiementDownload => 'Télécharger';

  @override
  String paiementEditStore(String store) {
    return 'Modifier le magasin $store';
  }

  @override
  String get paiementErrorDeleting => 'Erreur lors de la suppression';

  @override
  String get paiementErrorUpdatingStatus =>
      'Erreur lors de la mise à jour du statut';

  @override
  String paiementFromTo(DateTime from, DateTime to) {
    final intl.DateFormat fromDateFormat = intl.DateFormat.yMd(localeName);
    final String fromString = fromDateFormat.format(from);
    final intl.DateFormat toDateFormat = intl.DateFormat.yMd(localeName);
    final String toString = toDateFormat.format(to);

    return 'Du $fromString au $toString';
  }

  @override
  String get paiementGetBalanceError =>
      'Erreur lors de la récupération du solde : ';

  @override
  String get paiementGetTransactionsError =>
      'Erreur lors de la récupération des transactions : ';

  @override
  String get paiementHandOver => 'Passation';

  @override
  String get paiementHistory => 'Historique';

  @override
  String get paiementInvoiceCreatedSuccessfully => 'Facture créée avec succès';

  @override
  String get paiementInvoices => 'Factures';

  @override
  String paiementInvoicesPerPage(int quantity) {
    return '$quantity factures/page';
  }

  @override
  String get paiementLastTransactions => 'Dernières transactions';

  @override
  String get paiementLimitedTo => 'Limité à';

  @override
  String get paiementManagement => 'Gestion';

  @override
  String get paiementManageSellers => 'Gérer les vendeurs';

  @override
  String get paiementMarkPaid => 'Marquer comme payé';

  @override
  String get paiementMarkReceived => 'Marquer comme reçu';

  @override
  String get paiementMarkUnpaid => 'Marquer comme non payé';

  @override
  String get paiementMaxAmount =>
      'Le montant maximum de votre portefeuille est de';

  @override
  String get paiementMean => 'Moyenne : ';

  @override
  String get paiementModify => 'Modifier';

  @override
  String get paiementModifyingStoreError =>
      'Erreur lors de la modification du magasin';

  @override
  String get paiementModifySuccessfully => 'Modifié avec succès';

  @override
  String get paiementNewCGU => 'Nouvelles Conditions Générales d\'Utilisation';

  @override
  String get paiementNext => 'Suivant';

  @override
  String get paiementNextAccountable => 'Prochain responsable';

  @override
  String get paiementNoInvoiceToCreate => 'Aucune facture à créer';

  @override
  String get paiementNoMembership => 'Aucune adhésion';

  @override
  String get paiementNoMembershipDescription =>
      'Ce produit n\'est pas disponnible pour les non-adhérents. Confirmer l\'encaissement ?';

  @override
  String get paiementNoThanks => 'Non merci';

  @override
  String get paiementNoTransaction => 'Aucune transaction';

  @override
  String get paiementNoTransactionForThisMonth =>
      'Aucune transaction pour ce mois';

  @override
  String get paiementOf => 'de';

  @override
  String get paiementPaid => 'Payé';

  @override
  String get paiementPay => 'Payer';

  @override
  String get paiementPayment => 'Paiement';

  @override
  String get paiementPayWithHA => 'Payer avec HelloAsso';

  @override
  String get paiementPending => 'En attente';

  @override
  String get paiementPersonalBalance => 'Solde personnel';

  @override
  String get paiementPleaseAcceptPopup => 'Veuillez autoriser les popups';

  @override
  String get paiementPleaseAcceptTOS =>
      'Veuillez accepter les Conditions Générales d\'Utilisation.';

  @override
  String get paiementPleaseAddDevice =>
      'Veuillez ajouter cet appareil pour payer';

  @override
  String get paiementPleaseAuthenticate => 'Veuillez vous authentifier';

  @override
  String get paiementPleaseEnterMinAmount =>
      'Veuillez entrer un montant supérieur à 1';

  @override
  String get paiementPleaseEnterValidAmount =>
      'Veuillez entrer un montant valide';

  @override
  String get paiementProceedSuccessfully => 'Paiement effectué avec succès';

  @override
  String get paiementQRCodeAlreadyUsed => 'QR Code déjà utilisé';

  @override
  String get paiementReactivateRevokedDeviceDescription =>
      'Votre appareil a été révoqué. \nPour le réactiver, veuillez vous rendre sur la page des appareils.';

  @override
  String get paiementReceived => 'Reçu';

  @override
  String get paiementRefund => 'Remboursement';

  @override
  String get paiementRefundAction => 'Rembourser';

  @override
  String get paiementRefundedThe => 'Remboursé le';

  @override
  String get paiementRevokeDevice => 'Révoquer l\'appareil ?';

  @override
  String get paiementRevokeDeviceDescription =>
      'Vous ne pourrez plus utiliser cet appareil pour les paiements';

  @override
  String get paiementRightsOf => 'Droits de';

  @override
  String get paiementRightsUpdated => 'Droits mis à jour';

  @override
  String get paiementRightsUpdateError =>
      'Erreur lors de la mise à jour des droits';

  @override
  String get paiementScan => 'Scanner';

  @override
  String get paiementScanCode => 'Scanner un code';

  @override
  String get paiementSeeHistory => 'Voir l\'historique';

  @override
  String get paiementSelectStructure => 'Choisir une structure';

  @override
  String get paiementSellerError => 'Vous n\'êtes pas vendeur de ce magasin';

  @override
  String get paiementSellerRigths => 'Droits du vendeur';

  @override
  String get paiementSellersOf => 'Les vendeurs de';

  @override
  String get paiementSettings => 'Paramètres';

  @override
  String get paiementSpent => 'Déboursé';

  @override
  String get paiementStats => 'Stats';

  @override
  String get paiementStoreBalance => 'Solde du magasin';

  @override
  String get paiementStoreDeleted => 'Magasin supprimée';

  @override
  String paiementStructureManagement(String structure) {
    return 'Gestion de $structure';
  }

  @override
  String get paiementStoreName => 'Nom du magasin';

  @override
  String get paiementStores => 'Magasins';

  @override
  String get paiementStructureAdmin => 'Administrateur de la structure';

  @override
  String get paiementSuccededTransaction => 'Paiement réussi';

  @override
  String get paiementSuccessfullyAddedStore => 'Magasin ajoutée avec succès';

  @override
  String get paiementSuccessfullyModifiedStore =>
      'Magasin modifiée avec succès';

  @override
  String get paiementThe => 'Le';

  @override
  String get paiementThisDevice => '(cet appareil)';

  @override
  String get paiementTopUp => 'Recharge';

  @override
  String get paiementTopUpAction => 'Recharger';

  @override
  String get paiementTotalDuringPeriod => 'Total sur la période';

  @override
  String get paiementTransaction => 'ransaction';

  @override
  String get paiementTransactionCancelled => 'Transaction annulée';

  @override
  String get paiementTransactionCancelledDescription =>
      'Voulez-vous vraiment annuler la transaction de';

  @override
  String get paiementTransactionCancelledError =>
      'Erreur lors de l\'annulation de la transaction';

  @override
  String get paiementTransferStructure => 'Transfert de structure';

  @override
  String get paiementTransferStructureDescription =>
      'Le nouveau responsable aura accès à toutes les fonctionnalités de gestion de la structure. Vous allez recevoir un email pour valider ce transfert. Le lien ne sera actif que pendant 20 minutes. Cette action est irréversible. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get paiementTransferStructureError =>
      'Erreur lors du transfert de la structure';

  @override
  String get paiementTransferStructureSuccess =>
      'Transfert de structure demandé avec succès';

  @override
  String get paiementValidUntil => 'Valide jusqu\'à';

  @override
  String get paiementYouAreTransferingStructureTo =>
      'Vous êtes sur le point de transférer la structure à ';

  @override
  String get phAddNewJournal => 'Ajouter un nouveau journal';

  @override
  String get phNameField => 'Nom : ';

  @override
  String get phDateField => 'Date : ';

  @override
  String get phDelete => 'Voulez-vous vraiment supprimer ce journal ?';

  @override
  String get phIrreversibleAction => 'Cette action est irréversible';

  @override
  String get phToHeavyFile => 'Fichier trop volumineux';

  @override
  String get phAddPdfFile => 'Ajouter un fichier PDF';

  @override
  String get phEditPdfFile => 'Modifier le fichier PDF';

  @override
  String get phPhName => 'Nom du PH';

  @override
  String get phDate => 'Date';

  @override
  String get phAdded => 'Ajouté';

  @override
  String get phEdited => 'Modifié';

  @override
  String get phAddingFileError => 'Erreur d\'ajout';

  @override
  String get phMissingInformatonsOrPdf =>
      'Informations manquantes ou fichier PDF manquant';

  @override
  String get phAdd => 'Ajouter';

  @override
  String get phEdit => 'Modifier';

  @override
  String get phSeePreviousJournal => 'Voir les anciens journaux';

  @override
  String get phNoJournalInDatabase => 'Pas encore de PH dans la base de donnée';

  @override
  String get phSuccesDowloading => 'Téléchargé avec succès';

  @override
  String get phonebookAdd => 'Ajouter';

  @override
  String get phonebookAddAssociation => 'Ajouter une association';

  @override
  String get phonebookAddAssociationGroupement =>
      'Ajouter un groupement d\'association';

  @override
  String get phonebookAddedAssociation => 'Association ajoutée';

  @override
  String get phonebookAddedMember => 'Membre ajouté';

  @override
  String get phonebookAddingError => 'Erreur lors de l\'ajout';

  @override
  String get phonebookAddMember => 'Ajouter un membre';

  @override
  String get phonebookAddRole => 'Ajouter un rôle';

  @override
  String get phonebookAdmin => 'Admin';

  @override
  String get phonebookAll => 'Toutes';

  @override
  String get phonebookApparentName => 'Nom public du rôle :';

  @override
  String get phonebookAssociation => 'Association';

  @override
  String get phonebookAssociationDetail => 'Détail de l\'association :';

  @override
  String get phonebookAssociationGroupement => 'Groupement d\'association';

  @override
  String get phonebookAssociationKind => 'Type d\'association :';

  @override
  String get phonebookAssociationName => 'Nom de l\'association';

  @override
  String get phonebookAssociations => 'Associations';

  @override
  String get phonebookCancel => 'Annuler';

  @override
  String phonebookChangeTermYear(int year) {
    return 'Passer au mandat $year';
  }

  @override
  String get phonebookChangeTermConfirm =>
      'Êtes-vous sûr de vouloir changer tout le mandat ?\nCette action est irréversible !';

  @override
  String get phonebookClose => 'Fermer';

  @override
  String get phonebookConfirm => 'Confirmer';

  @override
  String get phonebookCopied => 'Copié dans le presse-papier';

  @override
  String get phonebookDeactivateAssociation => 'Désactiver l\'association';

  @override
  String get phonebookDeactivatedAssociation => 'Association désactivée';

  @override
  String get phonebookDeactivatedAssociationWarning =>
      'Attention, cette association est désactivée, vous ne pouvez pas la modifier';

  @override
  String phonebookDeactivateSelectedAssociation(String association) {
    return 'Désactiver l\'association $association ?';
  }

  @override
  String get phonebookDeactivatingError => 'Erreur lors de la désactivation';

  @override
  String get phonebookDetail => 'Détail :';

  @override
  String get phonebookDelete => 'Supprimer';

  @override
  String get phonebookDeleteAssociation => 'Supprimer l\'association';

  @override
  String phonebookDeleteSelectedAssociation(String association) {
    return 'Supprimer l\'association $association ?';
  }

  @override
  String get phonebookDeleteAssociationDescription =>
      'Ceci va supprimer l\'historique de l\'association';

  @override
  String get phonebookDeletedAssociation => 'Association supprimée';

  @override
  String get phonebookDeletedMember => 'Membre supprimé';

  @override
  String get phonebookDeleteRole => 'Supprimer le rôle';

  @override
  String phonebookDeleteUserRole(String name) {
    return 'Supprimer le rôle de l\'utilisateur $name ?';
  }

  @override
  String get phonebookDeactivating => 'Désactiver l\'association ?';

  @override
  String get phonebookDeleting => 'Suppression';

  @override
  String get phonebookDeletingError => 'Erreur lors de la suppression';

  @override
  String get phonebookDescription => 'Description';

  @override
  String get phonebookEdit => 'Modifier';

  @override
  String get phonebookEditAssociationGroupement =>
      'Modifier le groupement d\'association';

  @override
  String get phonebookEditAssociationGroups => 'Gérer les groupes';

  @override
  String get phonebookEditAssociationInfo => 'Modifier';

  @override
  String get phonebookEditAssociationMembers => 'Gérer les membres';

  @override
  String get phonebookEditRole => 'Modifier le rôle';

  @override
  String get phonebookEditMembership => 'Modifier le rôle';

  @override
  String get phonebookEmail => 'Email :';

  @override
  String get phonebookEmailCopied => 'Email copié dans le presse-papier';

  @override
  String get phonebookEmptyApparentName => 'Veuillez entrer un nom de role';

  @override
  String get phonebookEmptyFieldError => 'Un champ n\'est pas rempli';

  @override
  String get phonebookEmptyKindError =>
      'Veuillez choisir un type d\'association';

  @override
  String get phonebookEmptyMember => 'Aucun membre sélectionné';

  @override
  String get phonebookErrorAssociationLoading =>
      'Erreur lors du chargement de l\'association';

  @override
  String get phonebookErrorAssociationNameEmpty =>
      'Veuillez entrer un nom d\'association';

  @override
  String get phonebookErrorAssociationPicture =>
      'Erreur lors de la modification de la photo d\'association';

  @override
  String get phonebookErrorKindsLoading =>
      'Erreur lors du chargement des types d\'association';

  @override
  String get phonebookErrorLoadAssociationList =>
      'Erreur lors du chargement de la liste des associations';

  @override
  String get phonebookErrorLoadAssociationMember =>
      'Erreur lors du chargement des membres de l\'association';

  @override
  String get phonebookErrorLoadAssociationPicture =>
      'Erreur lors du chargement de la photo d\'association';

  @override
  String get phonebookErrorLoadProfilePicture => 'Erreur';

  @override
  String get phonebookErrorRoleTagsLoading =>
      'Erreur lors du chargement des tags de rôle';

  @override
  String get phonebookExistingMembership =>
      'Ce membre est déjà dans le mandat actuel';

  @override
  String get phonebookFilter => 'Filtrer';

  @override
  String get phonebookFilterDescription => 'Filtrer les associations par type';

  @override
  String get phonebookFirstname => 'Prénom :';

  @override
  String get phonebookGroupementDeleted => 'Groupement d\'association supprimé';

  @override
  String get phonebookGroupementDeleteError =>
      'Erreur lors de la suppression du groupement d\'association';

  @override
  String get phonebookGroupementName => 'Nom du groupement';

  @override
  String phonebookGroups(String association) {
    return 'Gérer les groupes de $association';
  }

  @override
  String phonebookTerm(int year) {
    return 'Mandat $year';
  }

  @override
  String get phonebookTermChangingError =>
      'Erreur lors du changement de mandat';

  @override
  String get phonebookMember => 'Membre';

  @override
  String get phonebookMemberReordered => 'Membre réordonné';

  @override
  String phonebookMembers(String association) {
    return 'Gérer les membres de $association';
  }

  @override
  String get phonebookMembershipAssociationError =>
      'Veuillez choisir une association';

  @override
  String get phonebookMembershipRole => 'Rôle :';

  @override
  String get phonebookMembershipRoleError => 'Veuillez choisir un rôle';

  @override
  String phonebookModifyMembership(String name) {
    return 'Modifier le rôle de $name';
  }

  @override
  String get phonebookName => 'Nom :';

  @override
  String get phonebookNameCopied => 'Nom et prénom copié dans le presse-papier';

  @override
  String get phonebookNamePure => 'Nom';

  @override
  String get phonebookNewTerm => 'Nouveau mandat';

  @override
  String get phonebookNewTermConfirmed => 'Mandat changé';

  @override
  String get phonebookNickname => 'Surnom :';

  @override
  String get phonebookNicknameCopied => 'Surnom copié dans le presse-papier';

  @override
  String get phonebookNoAssociationFound => 'Aucune association trouvée';

  @override
  String get phonebookNoMember => 'Aucun membre';

  @override
  String get phonebookNoMemberRole => 'Aucun role trouvé';

  @override
  String get phonebookNoRoleTags => 'Aucun tag de rôle trouvé';

  @override
  String get phonebookPhone => 'Téléphone :';

  @override
  String get phonebookPhonebook => 'Annuaire';

  @override
  String get phonebookPhonebookSearch => 'Rechercher';

  @override
  String get phonebookPhonebookSearchAssociation => 'Association';

  @override
  String get phonebookPhonebookSearchField => 'Rechercher :';

  @override
  String get phonebookPhonebookSearchName => 'Nom/Prénom/Surnom';

  @override
  String get phonebookPhonebookSearchRole => 'Poste';

  @override
  String get phonebookPresidentRoleTag => 'Prez\'';

  @override
  String get phonebookPromoNotGiven => 'Promo non renseignée';

  @override
  String phonebookPromotion(int year) {
    return 'Promotion $year';
  }

  @override
  String get phonebookReorderingError => 'Erreur lors du réordonnement';

  @override
  String get phonebookResearch => 'Rechercher';

  @override
  String get phonebookRolePure => 'Rôle';

  @override
  String get phonebookSearchUser => 'Rechercher un utilisateur';

  @override
  String get phonebookTooHeavyAssociationPicture =>
      'L\'image est trop lourde (max 4Mo)';

  @override
  String get phonebookUpdateGroups => 'Mettre à jour les groupes';

  @override
  String get phonebookUpdatedAssociation => 'Association modifiée';

  @override
  String get phonebookUpdatedAssociationPicture =>
      'La photo d\'association a été changée';

  @override
  String get phonebookUpdatedGroups => 'Groupes mis à jour';

  @override
  String get phonebookUpdatedMember => 'Membre modifié';

  @override
  String get phonebookUpdatingError => 'Erreur lors de la modification';

  @override
  String get phonebookValidation => 'Valider';

  @override
  String get purchasesPurchases => 'Achats';

  @override
  String get purchasesResearch => 'Rechercher';

  @override
  String get purchasesNoPurchasesFound => 'Aucun achat trouvé';

  @override
  String get purchasesNoTickets => 'Aucun ticket';

  @override
  String get purchasesTicketsError => 'Erreur lors du chargement des tickets';

  @override
  String get purchasesPurchasesError => 'Erreur lors du chargement des achats';

  @override
  String get purchasesNoPurchases => 'Aucun achat';

  @override
  String get purchasesTimes => 'fois';

  @override
  String get purchasesAlreadyUsed => 'Déjà utilisé';

  @override
  String get purchasesNotPaid => 'Non validé';

  @override
  String get purchasesPleaseSelectProduct => 'Veuillez sélectionner un produit';

  @override
  String get purchasesProducts => 'Produits';

  @override
  String get purchasesCancel => 'Annuler';

  @override
  String get purchasesValidate => 'Valider';

  @override
  String get purchasesLeftScan => 'Scans restants';

  @override
  String get purchasesTag => 'Tag';

  @override
  String get purchasesHistory => 'Historique';

  @override
  String get purchasesPleaseSelectSeller => 'Veuillez sélectionner un vendeur';

  @override
  String get purchasesNoTagGiven => 'Attention, aucun tag n\'a été entré';

  @override
  String get purchasesTickets => 'Tickets';

  @override
  String get purchasesNoScannableProducts => 'Aucun produit scannable';

  @override
  String get purchasesLoading => 'En attente de scan';

  @override
  String get purchasesScan => 'Scanner';

  @override
  String get raffleRaffle => 'Tombola';

  @override
  String get rafflePrize => 'Lot';

  @override
  String get rafflePrizes => 'Lots';

  @override
  String get raffleActualRaffles => 'Tombola en cours';

  @override
  String get rafflePastRaffles => 'Tombola passés';

  @override
  String get raffleYourTickets => 'Tous vos tickets';

  @override
  String get raffleCreateMenu => 'Menu de Création';

  @override
  String get raffleNextRaffles => 'Prochaines tombolas';

  @override
  String get raffleNoTicket => 'Vous n\'avez pas de ticket';

  @override
  String get raffleSeeRaffleDetail => 'Voir lots/tickets';

  @override
  String get raffleActualPrize => 'Lots actuels';

  @override
  String get raffleMajorPrize => 'Lot Majeurs';

  @override
  String get raffleTakeTickets => 'Prendre vos tickets';

  @override
  String get raffleNoTicketBuyable =>
      'Vous ne pouvez pas achetez de billets pour l\'instant';

  @override
  String get raffleNoCurrentPrize => 'Il n\'y a aucun lots actuellement';

  @override
  String get raffleModifTombola =>
      'Vous pouvez modifiez vos tombolas ou en créer de nouvelles, toute décision doit ensuite être prise par les admins';

  @override
  String get raffleCreateYourRaffle => 'Votre menu de création de tombolas';

  @override
  String get rafflePossiblePrice => 'Prix possible';

  @override
  String get raffleInformation => 'Information et Statistiques';

  @override
  String get raffleAccounts => 'Comptes';

  @override
  String get raffleAdd => 'Ajouter';

  @override
  String get raffleUpdatedAmount => 'Montant mis à jour';

  @override
  String get raffleUpdatingError => 'Erreur lors de la mise à jour';

  @override
  String get raffleDeletedPrize => 'Lot supprimé';

  @override
  String get raffleDeletingError => 'Erreur lors de la suppression';

  @override
  String get raffleQuantity => 'Quantité';

  @override
  String get raffleClose => 'Fermer';

  @override
  String get raffleOpen => 'Ouvrir';

  @override
  String get raffleAddTypeTicketSimple => 'Ajouter';

  @override
  String get raffleAddingError => 'Erreur lors de l\'ajout';

  @override
  String get raffleEditTypeTicketSimple => 'Modifier';

  @override
  String get raffleFillField => 'Le champ ne peut pas être vide';

  @override
  String get raffleWaiting => 'Chargement';

  @override
  String get raffleEditingError => 'Erreur lors de la modification';

  @override
  String get raffleAddedTicket => 'Ticket ajouté';

  @override
  String get raffleEditedTicket => 'Ticket modifié';

  @override
  String get raffleAlreadyExistTicket => 'Le ticket existe déjà';

  @override
  String get raffleNumberExpected => 'Un entier est attendu';

  @override
  String get raffleDeletedTicket => 'Ticket supprimé';

  @override
  String get raffleAddPrize => 'Ajouter';

  @override
  String get raffleEditPrize => 'Modifier';

  @override
  String get raffleOpenRaffle => 'Ouvrir la tombola';

  @override
  String get raffleCloseRaffle => 'Fermer la tombola';

  @override
  String get raffleOpenRaffleDescription =>
      'Vous allez ouvrir la tombola, les utilisateurs pourront acheter des tickets. Vous ne pourrez plus modifier la tombola. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get raffleCloseRaffleDescription =>
      'Vous allez fermer la tombola, les utilisateurs ne pourront plus acheter de tickets. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get raffleNoCurrentRaffle => 'Il n\'y a aucune tombola en cours';

  @override
  String get raffleBoughtTicket => 'Ticket acheté';

  @override
  String get raffleDrawingError => 'Erreur lors du tirage';

  @override
  String get raffleInvalidPrice => 'Le prix doit être supérieur à 0';

  @override
  String get raffleMustBePositive => 'Le nombre doit être strictement positif';

  @override
  String get raffleDraw => 'Tirer';

  @override
  String get raffleDrawn => 'Tiré';

  @override
  String get raffleError => 'Erreur';

  @override
  String get raffleGathered => 'Récolté';

  @override
  String get raffleTickets => 'Tickets';

  @override
  String get raffleTicket => 'ticket';

  @override
  String get raffleWinner => 'Gagnant';

  @override
  String get raffleNoPrize => 'Aucun lot';

  @override
  String get raffleDeletePrize => 'Supprimer le lot';

  @override
  String get raffleDeletePrizeDescription =>
      'Vous allez supprimer le lot, êtes-vous sûr de vouloir continuer ?';

  @override
  String get raffleDrawing => 'Tirage';

  @override
  String get raffleDrawingDescription => 'Tirer le gagnant du lot ?';

  @override
  String get raffleDeleteTicket => 'Supprimer le ticket';

  @override
  String get raffleDeleteTicketDescription =>
      'Vous allez supprimer le ticket, êtes-vous sûr de vouloir continuer ?';

  @override
  String get raffleWinningTickets => 'Tickets gagnants';

  @override
  String get raffleNoWinningTicketYet =>
      'Les tickets gagnants seront affichés ici';

  @override
  String get raffleName => 'Nom';

  @override
  String get raffleDescription => 'Description';

  @override
  String get raffleBuyThisTicket => 'Acheter ce ticket';

  @override
  String get raffleLockedRaffle => 'Tombola verrouillée';

  @override
  String get raffleUnavailableRaffle => 'Tombola indisponible';

  @override
  String get raffleNotEnoughMoney => 'Vous n\'avez pas assez d\'argent';

  @override
  String get raffleWinnable => 'gagnable';

  @override
  String get raffleNoDescription => 'Aucune description';

  @override
  String get raffleAmount => 'Solde';

  @override
  String get raffleLoading => 'Chargement';

  @override
  String get raffleTicketNumber => 'Nombre de ticket';

  @override
  String get rafflePrice => 'Prix';

  @override
  String get raffleEditRaffle => 'Modifier la tombola';

  @override
  String get raffleEdit => 'Modifier';

  @override
  String get raffleAddPackTicket => 'Ajouter un pack de ticket';

  @override
  String get recommendationRecommendation => 'Bons plans';

  @override
  String get recommendationTitle => 'Titre';

  @override
  String get recommendationLogo => 'Logo';

  @override
  String get recommendationCode => 'Code';

  @override
  String get recommendationSummary => 'Court résumé';

  @override
  String get recommendationDescription => 'Description';

  @override
  String get recommendationAdd => 'Ajouter';

  @override
  String get recommendationEdit => 'Modifier';

  @override
  String get recommendationDelete => 'Supprimer';

  @override
  String get recommendationAddImage => 'Veuillez ajouter une image';

  @override
  String get recommendationAddedRecommendation => 'Bon plan ajouté';

  @override
  String get recommendationEditedRecommendation => 'Bon plan modifié';

  @override
  String get recommendationDeleteRecommendationConfirmation =>
      'Êtes-vous sûr de vouloir supprimer ce bon plan ?';

  @override
  String get recommendationDeleteRecommendation => 'Suppresion';

  @override
  String get recommendationDeletingRecommendationError =>
      'Erreur lors de la suppression';

  @override
  String get recommendationDeletedRecommendation => 'Bon plan supprimé';

  @override
  String get recommendationIncorrectOrMissingFields =>
      'Champs incorrects ou manquants';

  @override
  String get recommendationEditingError => 'Échec de la modification';

  @override
  String get recommendationAddingError => 'Échec de l\'ajout';

  @override
  String get recommendationCopiedCode => 'Code de réduction copié';

  @override
  String get seedLibraryAdd => 'Ajouter';

  @override
  String get seedLibraryAddedPlant => 'Plante ajoutée';

  @override
  String get seedLibraryAddedSpecies => 'Espèce ajoutée';

  @override
  String get seedLibraryAddingError => 'Erreur lors de l\'ajout';

  @override
  String get seedLibraryAddPlant => 'Déposer une plante';

  @override
  String get seedLibraryAddSpecies => 'Ajouter une espèce';

  @override
  String get seedLibraryAll => 'Toutes';

  @override
  String get seedLibraryAncestor => 'Ancêtre';

  @override
  String get seedLibraryAround => 'environ';

  @override
  String get seedLibraryAutumn => 'Automne';

  @override
  String get seedLibraryBorrowedPlant => 'Plante empruntée';

  @override
  String get seedLibraryBorrowingDate => 'Date d\'emprunt :';

  @override
  String get seedLibraryBorrowPlant => 'Emprunter la plante';

  @override
  String get seedLibraryCard => 'Carte';

  @override
  String get seedLibraryChoosingAncestor => 'Veuillez choisir un ancêtre';

  @override
  String get seedLibraryChoosingSpecies => 'Veuillez choisir une espèce';

  @override
  String get seedLibraryChoosingSpeciesOrAncestor =>
      'Veuillez choisir une espèce ou un ancêtre';

  @override
  String get seedLibraryContact => 'Contact :';

  @override
  String get seedLibraryDays => 'jours';

  @override
  String get seedLibraryDeadMsg => 'Voulez-vous déclarer la plante morte ?';

  @override
  String get seedLibraryDeadPlant => 'Plante morte';

  @override
  String get seedLibraryDeathDate => 'Date de mort';

  @override
  String get seedLibraryDeletedSpecies => 'Espèce supprimée';

  @override
  String get seedLibraryDeleteSpecies => 'Supprimer l\'espèce ?';

  @override
  String get seedLibraryDeleting => 'Suppression';

  @override
  String get seedLibraryDeletingError => 'Erreur lors de la suppression';

  @override
  String get seedLibraryDepositNotAvailable =>
      'Le dépôt de plantes n\'est pas possible sans emprunter une plante au préalable';

  @override
  String get seedLibraryDescription => 'Description';

  @override
  String get seedLibraryDifficulty => 'Difficulté :';

  @override
  String get seedLibraryEdit => 'Modifier';

  @override
  String get seedLibraryEditedPlant => 'Plante modifiée';

  @override
  String get seedLibraryEditInformation => 'Modifier les informations';

  @override
  String get seedLibraryEditingError => 'Erreur lors de la modification';

  @override
  String get seedLibraryEditSpecies => 'Modifier l\'espèce';

  @override
  String get seedLibraryEmptyDifficultyError =>
      'Veuillez choisir une difficulté';

  @override
  String get seedLibraryEmptyFieldError => 'Veuillez remplir tous les champs';

  @override
  String get seedLibraryEmptyTypeError => 'Veuillez choisir un type de plante';

  @override
  String get seedLibraryEndMonth => 'Mois de fin :';

  @override
  String get seedLibraryFacebookUrl => 'Lien Facebook';

  @override
  String get seedLibraryFilters => 'Filtres';

  @override
  String get seedLibraryForum =>
      'Oskour maman j\'ai tué ma plante - Forum d\'aide';

  @override
  String get seedLibraryForumUrl => 'Lien Forum';

  @override
  String get seedLibraryHelpSheets => 'Fiches sur les plantes';

  @override
  String get seedLibraryInformation => 'Informations :';

  @override
  String get seedLibraryMaturationTime => 'Temps de maturation';

  @override
  String get seedLibraryMonthJan => 'Janvier';

  @override
  String get seedLibraryMonthFeb => 'Février';

  @override
  String get seedLibraryMonthMar => 'Mars';

  @override
  String get seedLibraryMonthApr => 'Avril';

  @override
  String get seedLibraryMonthMay => 'Mai';

  @override
  String get seedLibraryMonthJun => 'Juin';

  @override
  String get seedLibraryMonthJul => 'Juillet';

  @override
  String get seedLibraryMonthAug => 'Août';

  @override
  String get seedLibraryMonthSep => 'Septembre';

  @override
  String get seedLibraryMonthOct => 'Octobre';

  @override
  String get seedLibraryMonthNov => 'Novembre';

  @override
  String get seedLibraryMonthDec => 'Décembre';

  @override
  String get seedLibraryMyPlants => 'Mes plantes';

  @override
  String get seedLibraryName => 'Nom';

  @override
  String get seedLibraryNbSeedsRecommended => 'Nombre de graines recommandées';

  @override
  String get seedLibraryNbSeedsRecommendedError =>
      'Veuillez entrer un nombre de graines recommandé supérieur à 0';

  @override
  String get seedLibraryNoDateError => 'Veuillez entrer une date';

  @override
  String get seedLibraryNoFilteredPlants =>
      'Aucune plante ne correspond à votre recherche. Essayez d\'autres filtres.';

  @override
  String get seedLibraryNoMorePlant => 'Aucune plante n\'est disponible';

  @override
  String get seedLibraryNoPersonalPlants =>
      'Vous n\'avez pas encore de plantes dans votre grainothèque. Vous pouvez en ajouter en allant dans les stocks.';

  @override
  String get seedLibraryNoSpecies => 'Aucune espèce trouvée';

  @override
  String get seedLibraryNoStockPlants =>
      'Aucune plante disponible dans le stock';

  @override
  String get seedLibraryNotes => 'Notes';

  @override
  String get seedLibraryOk => 'OK';

  @override
  String get seedLibraryPlantationPeriod => 'Période de plantation :';

  @override
  String get seedLibraryPlantationType => 'Type de plantation :';

  @override
  String get seedLibraryPlantDetail => 'Détail de la plante';

  @override
  String get seedLibraryPlantingDate => 'Date de plantation';

  @override
  String get seedLibraryPlantingNow => 'Je la plante maintenant';

  @override
  String get seedLibraryPrefix => 'Préfixe';

  @override
  String get seedLibraryPrefixError => 'Prefixe déjà utilisé';

  @override
  String get seedLibraryPrefixLengthError =>
      'Le préfixe doit faire 3 caractères';

  @override
  String get seedLibraryPropagationMethod => 'Méthode de propagation :';

  @override
  String get seedLibraryReference => 'Référence :';

  @override
  String get seedLibraryRemovedPlant => 'Plante supprimée';

  @override
  String get seedLibraryRemovingError => 'Erreur lors de la suppression';

  @override
  String get seedLibraryResearch => 'Recherche';

  @override
  String get seedLibrarySaveChanges => 'Sauvegarder les modifications';

  @override
  String get seedLibrarySeason => 'Saison :';

  @override
  String get seedLibrarySeed => 'Graine';

  @override
  String get seedLibrarySeeds => 'graines';

  @override
  String get seedLibrarySeedDeposit => 'Dépôt de plantes';

  @override
  String get seedLibrarySeedLibrary => 'Grainothèque';

  @override
  String get seedLibrarySeedQuantitySimple => 'Quantité de graines';

  @override
  String get seedLibrarySeedQuantity => 'Quantité de graines :';

  @override
  String get seedLibraryShowDeadPlants => 'Afficher les plantes mortes';

  @override
  String get seedLibrarySpecies => 'Espèce :';

  @override
  String get seedLibrarySpeciesHelp => 'Aide sur l\'espèce';

  @override
  String get seedLibrarySpeciesPlural => 'Espèces';

  @override
  String get seedLibrarySpeciesSimple => 'Espèce';

  @override
  String get seedLibrarySpeciesType => 'Type d\'espèce :';

  @override
  String get seedLibrarySpring => 'Printemps';

  @override
  String get seedLibraryStartMonth => 'Mois de début :';

  @override
  String get seedLibraryStock => 'Stock disponible';

  @override
  String get seedLibrarySummer => 'Été';

  @override
  String get seedLibraryStocks => 'Stocks';

  @override
  String get seedLibraryTimeUntilMaturation => 'Temps avant maturation :';

  @override
  String get seedLibraryType => 'Type :';

  @override
  String get seedLibraryUnableToOpen => 'Impossible d\'ouvrir le lien';

  @override
  String get seedLibraryUpdate => 'Modifier';

  @override
  String get seedLibraryUpdatedInformation => 'Informations modifiées';

  @override
  String get seedLibraryUpdatedSpecies => 'Espèce modifiée';

  @override
  String get seedLibraryUpdatedPlant => 'Plante modifiée';

  @override
  String get seedLibraryUpdatingError => 'Erreur lors de la modification';

  @override
  String get seedLibraryWinter => 'Hiver';

  @override
  String get seedLibraryWriteReference =>
      'Veuillez écrire la référence suivante : ';

  @override
  String get settingsAccount => 'Compte';

  @override
  String get settingsAddProfilePicture => 'Ajouter une photo';

  @override
  String get settingsAdmin => 'Administrateur';

  @override
  String get settingsAskHelp => 'Demander de l\'aide';

  @override
  String get settingsAssociation => 'Association';

  @override
  String get settingsBirthday => 'Date de naissance';

  @override
  String get settingsBugs => 'Bugs';

  @override
  String get settingsChangePassword => 'Changer de mot de passe';

  @override
  String get settingsChangingPassword =>
      'Voulez-vous vraiment changer votre mot de passe ?';

  @override
  String get settingsConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get settingsCopied => 'Copié !';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String get settingsDarkModeOff => 'Désactivé';

  @override
  String get settingsDeleteLogs => 'Supprimer les logs ?';

  @override
  String get settingsDeleteNotificationLogs =>
      'Supprimer les logs des notifications ?';

  @override
  String get settingsDetelePersonalData => 'Supprimer mes données personnelles';

  @override
  String get settingsDetelePersonalDataDesc =>
      'Cette action notifie l\'administrateur que vous souhaitez supprimer vos données personnelles.';

  @override
  String get settingsDeleting => 'Suppresion';

  @override
  String get settingsEdit => 'Modifier';

  @override
  String get settingsEditAccount => 'Modifier mon profil';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsEmptyField => 'Ce champ ne peut pas être vide';

  @override
  String get settingsErrorProfilePicture =>
      'Erreur lors de la modification de la photo de profil';

  @override
  String get settingsErrorSendingDemand =>
      'Erreur lors de l\'envoi de la demande';

  @override
  String get settingsEventsIcal => 'Lien Ical des événements';

  @override
  String get settingsExpectingDate => 'Date de naissance attendue';

  @override
  String get settingsFirstname => 'Prénom';

  @override
  String get settingsFloor => 'Étage';

  @override
  String get settingsHelp => 'Aide';

  @override
  String get settingsIcalCopied => 'Lien Ical copié !';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageVar => 'Français 🇫🇷';

  @override
  String get settingsLogs => 'Logs';

  @override
  String get settingsModules => 'Modules';

  @override
  String get settingsMyIcs => 'Mon lien Ical';

  @override
  String get settingsName => 'Nom';

  @override
  String get settingsNewPassword => 'Nouveau mot de passe';

  @override
  String get settingsNickname => 'Surnom';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsOldPassword => 'Ancien mot de passe';

  @override
  String get settingsPasswordChanged => 'Mot de passe changé';

  @override
  String get settingsPasswordsNotMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get settingsPersonalData => 'Données personnelles';

  @override
  String get settingsPersonalisation => 'Personnalisation';

  @override
  String get settingsPhone => 'Téléphone';

  @override
  String get settingsProfilePicture => 'Photo de profil';

  @override
  String get settingsPromo => 'Promotion';

  @override
  String get settingsRepportBug => 'Signaler un bug';

  @override
  String get settingsSave => 'Enregistrer';

  @override
  String get settingsSecurity => 'Sécurité';

  @override
  String get settingsSendedDemand => 'Demande envoyée';

  @override
  String get settingsSettings => 'Paramètres';

  @override
  String get settingsTooHeavyProfilePicture =>
      'L\'image est trop lourde (max 4Mo)';

  @override
  String get settingsUpdatedProfile => 'Profil modifié';

  @override
  String get settingsUpdatedProfilePicture => 'Photo de profil modifiée';

  @override
  String get settingsUpdateNotification => 'Mettre à jour les notifications';

  @override
  String get settingsUpdatingError =>
      'Erreur lors de la modification du profil';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsPasswordStrength => 'Force du mot de passe';

  @override
  String get settingsPasswordStrengthVeryWeak => 'Très faible';

  @override
  String get settingsPasswordStrengthWeak => 'Faible';

  @override
  String get settingsPasswordStrengthMedium => 'Moyen';

  @override
  String get settingsPasswordStrengthStrong => 'Fort';

  @override
  String get settingsPasswordStrengthVeryStrong => 'Très fort';

  @override
  String get settingsPhoneNumber => 'Numéro de téléphone';

  @override
  String get settingsValidate => 'Valider';

  @override
  String get settingsEditedAccount => 'Compte modifié avec succès';

  @override
  String get settingsFailedToEditAccount =>
      'Échec de la modification du compte';

  @override
  String get settingsChooseLanguage => 'Choix de la langue';

  @override
  String settingsNotificationCounter(int active, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      active,
      locale: localeName,
      other: 'activées',
      one: 'activée',
      zero: 'activée',
    );
    return '$active/$total $_temp0';
  }

  @override
  String get settingsEvent => 'Événement';

  @override
  String get settingsIcal => 'Lien Ical';

  @override
  String get settingsSynncWithCalendar => 'Synchroniser avec votre calendrier';

  @override
  String get settingsIcalLinkCopied => 'Lien Ical copié dans le presse-papier';

  @override
  String get settingsProfile => 'Profil';

  @override
  String get settingsConnexion => 'Connexion';

  @override
  String get settingsDisconnect => 'Se déconnecter';

  @override
  String get settingsDisconnectDescription =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get settingsDisconnectionSuccess => 'Déconnexion réussie';

  @override
  String get settingsDeleteMyAccount => 'Supprimer mon compte';

  @override
  String get settingsDeleteMyAccountDescription =>
      'Cette action notifie l\'administrateur que vous souhaitez supprimer votre compte.';

  @override
  String get settingsDeletionAsked =>
      'Demande de suppression de compte envoyée';

  @override
  String get settingsDeleteMyAccountError =>
      'Erreur lors de la demande de suppression de compte';

  @override
  String get voteAdd => 'Ajouter';

  @override
  String get voteAddMember => 'Ajouter un membre';

  @override
  String get voteAddedPretendance => 'Liste ajoutée';

  @override
  String get voteAddedSection => 'Section ajoutée';

  @override
  String get voteAddingError => 'Erreur lors de l\'ajout';

  @override
  String get voteAddPretendance => 'Ajouter une liste';

  @override
  String get voteAddSection => 'Ajouter une section';

  @override
  String get voteAll => 'Tous';

  @override
  String get voteAlreadyAddedMember => 'Membre déjà ajouté';

  @override
  String get voteAlreadyVoted => 'Vote enregistré';

  @override
  String get voteChooseList => 'Choisir une liste';

  @override
  String get voteClear => 'Réinitialiser';

  @override
  String get voteClearVotes => 'Réinitialiser les votes';

  @override
  String get voteClosedVote => 'Votes clos';

  @override
  String get voteCloseVote => 'Fermer les votes';

  @override
  String get voteConfirmVote => 'Confirmer le vote';

  @override
  String get voteCountVote => 'Dépouiller les votes';

  @override
  String get voteDeletedAll => 'Tout supprimé';

  @override
  String get voteDeletedPipo => 'Listes pipos supprimées';

  @override
  String get voteDeletedSection => 'Section supprimée';

  @override
  String get voteDeleteAll => 'Supprimer tout';

  @override
  String get voteDeleteAllDescription =>
      'Voulez-vous vraiment supprimer tout ?';

  @override
  String get voteDeletePipo => 'Supprimer les listes pipos';

  @override
  String get voteDeletePipoDescription =>
      'Voulez-vous vraiment supprimer les listes pipos ?';

  @override
  String get voteDeletePretendance => 'Supprimer la liste';

  @override
  String get voteDeletePretendanceDesc =>
      'Voulez-vous vraiment supprimer cette liste ?';

  @override
  String get voteDeleteSection => 'Supprimer la section';

  @override
  String get voteDeleteSectionDescription =>
      'Voulez-vous vraiment supprimer cette section ?';

  @override
  String get voteDeletingError => 'Erreur lors de la suppression';

  @override
  String get voteDescription => 'Description';

  @override
  String get voteEdit => 'Modifier';

  @override
  String get voteEditedPretendance => 'Liste modifiée';

  @override
  String get voteEditedSection => 'Section modifiée';

  @override
  String get voteEditingError => 'Erreur lors de la modification';

  @override
  String get voteErrorClosingVotes => 'Erreur lors de la fermeture des votes';

  @override
  String get voteErrorCountingVotes => 'Erreur lors du dépouillement des votes';

  @override
  String get voteErrorResetingVotes =>
      'Erreur lors de la réinitialisation des votes';

  @override
  String get voteErrorOpeningVotes => 'Erreur lors de l\'ouverture des votes';

  @override
  String get voteIncorrectOrMissingFields => 'Champs incorrects ou manquants';

  @override
  String get voteMembers => 'Membres';

  @override
  String get voteName => 'Nom';

  @override
  String get voteNoPretendanceList => 'Aucune liste de prétendance';

  @override
  String get voteNoSection => 'Aucune section';

  @override
  String get voteCanNotVote => 'Vous ne pouvez pas voter';

  @override
  String get voteNoSectionList => 'Aucune section';

  @override
  String get voteNotOpenedVote => 'Vote non ouvert';

  @override
  String get voteOnGoingCount => 'Dépouillement en cours';

  @override
  String get voteOpenVote => 'Ouvrir les votes';

  @override
  String get votePipo => 'Pipo';

  @override
  String get votePretendance => 'Listes';

  @override
  String get votePretendanceDeleted => 'Prétendance supprimée';

  @override
  String get votePretendanceNotDeleted => 'Erreur lors de la suppression';

  @override
  String get voteProgram => 'Programme';

  @override
  String get votePublish => 'Publier';

  @override
  String get votePublishVoteDescription =>
      'Voulez-vous vraiment publier les votes ?';

  @override
  String get voteResetedVotes => 'Votes réinitialisés';

  @override
  String get voteResetVote => 'Réinitialiser les votes';

  @override
  String get voteResetVoteDescription => 'Que voulez-vous faire ?';

  @override
  String get voteRole => 'Rôle';

  @override
  String get voteSectionDescription => 'Description de la section';

  @override
  String get voteSection => 'Section';

  @override
  String get voteSectionName => 'Nom de la section';

  @override
  String get voteSeeMore => 'Voir plus';

  @override
  String get voteSelected => 'Sélectionné';

  @override
  String get voteShowVotes => 'Voir les votes';

  @override
  String get voteVote => 'Vote';

  @override
  String get voteVoteError => 'Erreur lors de l\'enregistrement du vote';

  @override
  String get voteVoteFor => 'Voter pour ';

  @override
  String get voteVoteNotStarted => 'Vote non ouvert';

  @override
  String get voteVoters => 'Groupes votants';

  @override
  String get voteVoteSuccess => 'Vote enregistré';

  @override
  String get voteVotes => 'Voix';

  @override
  String get voteVotesClosed => 'Votes clos';

  @override
  String get voteVotesCounted => 'Votes dépouillés';

  @override
  String get voteVotesOpened => 'Votes ouverts';

  @override
  String get voteWarning => 'Attention';

  @override
  String get voteWarningMessage =>
      'La sélection ne sera pas sauvegardée.\nVoulez-vous continuer ?';

  @override
  String get moduleAdvert => 'Annonce';

  @override
  String get moduleAdvertDescription => 'Gérer les annonces';

  @override
  String get moduleAmap => 'AMAP';

  @override
  String get moduleAmapDescription => 'Gérer les livraisons et les produits';

  @override
  String get moduleBooking => 'Réservation';

  @override
  String get moduleBookingDescription =>
      'Gérer les réservations, les salles et les managers';

  @override
  String get moduleCalendar => 'Calendrier';

  @override
  String get moduleCalendarDescription =>
      'Consulter les événements et les activités';

  @override
  String get moduleCentralisation => 'Centralisation';

  @override
  String get moduleCentralisationDescription =>
      'Gérer la centralisation des données';

  @override
  String get moduleCinema => 'Cinéma';

  @override
  String get moduleCinemaDescription => 'Gérer les séances de cinéma';

  @override
  String get moduleEvent => 'Événement';

  @override
  String get moduleEventDescription =>
      'Gérer les événements et les participants';

  @override
  String get moduleFlappyBird => 'Flappy Bird';

  @override
  String get moduleFlappyBirdDescription =>
      'Jouer à Flappy Bird et consulter le classement';

  @override
  String get moduleLoan => 'Prêt';

  @override
  String get moduleLoanDescription => 'Gérer les prêts et les articles';

  @override
  String get modulePhonebook => 'Annuaire';

  @override
  String get modulePhonebookDescription =>
      'Gérer les associations, les membres et les administrateurs';

  @override
  String get modulePurchases => 'Achats';

  @override
  String get modulePurchasesDescription =>
      'Gérer les achats, les tickets et l\'historique';

  @override
  String get moduleRaffle => 'Tombola';

  @override
  String get moduleRaffleDescription =>
      'Gérer les tombolas, les prix et les tickets';

  @override
  String get moduleRecommendation => 'Bons plans';

  @override
  String get moduleRecommendationDescription =>
      'Gérer les recommandations, les informations et les administrateurs';

  @override
  String get moduleSeedLibrary => 'Grainothèque';

  @override
  String get moduleSeedLibraryDescription =>
      'Gérer les graines, les espèces et les stocks';

  @override
  String get moduleVote => 'Vote';

  @override
  String get moduleVoteDescription =>
      'Gérer les votes, les sections et les candidats';

  @override
  String get modulePh => 'PH';

  @override
  String get modulePhDescription =>
      'Gérer les PH, les formulaires et les administrateurs';

  @override
  String get moduleSettings => 'Paramètres';

  @override
  String get moduleSettingsDescription =>
      'Gérer les paramètres de l\'application';

  @override
  String get moduleFeed => 'Feed';

  @override
  String get moduleFeedDescription =>
      'Consulter les actualités et mises à jour';

  @override
  String get moduleStyleGuide => 'StyleGuide';

  @override
  String get moduleStyleGuideDescription =>
      'Explore the UI components and styles used in Titan';

  @override
  String get moduleAdmin => 'Admin';

  @override
  String get moduleAdminDescription =>
      'Gérer les utilisateurs, groupes et structures';

  @override
  String get moduleOthers => 'Autres';

  @override
  String get moduleOthersDescription => 'Afficher les autres modules';

  @override
  String get modulePayment => 'Paiement';

  @override
  String get modulePaymentDescription =>
      'Gérer les paiements, les statistiques et les appareils';
}
