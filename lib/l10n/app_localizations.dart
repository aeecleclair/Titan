import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @dateToday.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get dateToday;

  /// No description provided for @dateYesterday.
  ///
  /// In fr, this message translates to:
  /// **'Hier'**
  String get dateYesterday;

  /// No description provided for @dateTomorrow.
  ///
  /// In fr, this message translates to:
  /// **'Demain'**
  String get dateTomorrow;

  /// No description provided for @dateAt.
  ///
  /// In fr, this message translates to:
  /// **'à'**
  String get dateAt;

  /// No description provided for @dateFrom.
  ///
  /// In fr, this message translates to:
  /// **'de'**
  String get dateFrom;

  /// No description provided for @dateTo.
  ///
  /// In fr, this message translates to:
  /// **'à'**
  String get dateTo;

  /// No description provided for @dateBetweenDays.
  ///
  /// In fr, this message translates to:
  /// **'au'**
  String get dateBetweenDays;

  /// No description provided for @dateStarting.
  ///
  /// In fr, this message translates to:
  /// **'Commence'**
  String get dateStarting;

  /// No description provided for @dateLast.
  ///
  /// In fr, this message translates to:
  /// **''**
  String get dateLast;

  /// No description provided for @dateUntil.
  ///
  /// In fr, this message translates to:
  /// **'Jusqu\'au'**
  String get dateUntil;

  /// No description provided for @feedFilterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get feedFilterAll;

  /// No description provided for @feedFilterPending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get feedFilterPending;

  /// No description provided for @feedFilterApproved.
  ///
  /// In fr, this message translates to:
  /// **'Approuvés'**
  String get feedFilterApproved;

  /// No description provided for @feedFilterRejected.
  ///
  /// In fr, this message translates to:
  /// **'Rejetés'**
  String get feedFilterRejected;

  /// No description provided for @feedEmptyAll.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement disponible'**
  String get feedEmptyAll;

  /// No description provided for @feedEmptyPending.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement en attente de validation'**
  String get feedEmptyPending;

  /// No description provided for @feedEmptyApproved.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement approuvé'**
  String get feedEmptyApproved;

  /// No description provided for @feedEmptyRejected.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement rejeté'**
  String get feedEmptyRejected;

  /// No description provided for @feedEventManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des événements'**
  String get feedEventManagement;

  /// No description provided for @feedTitle.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get feedTitle;

  /// No description provided for @feedLocation.
  ///
  /// In fr, this message translates to:
  /// **'Lieu'**
  String get feedLocation;

  /// No description provided for @feedSGDate.
  ///
  /// In fr, this message translates to:
  /// **'Date du SG'**
  String get feedSGDate;

  /// No description provided for @feedSGExternalLink.
  ///
  /// In fr, this message translates to:
  /// **'Lien externe du SG'**
  String get feedSGExternalLink;

  /// No description provided for @feedCreateEvent.
  ///
  /// In fr, this message translates to:
  /// **'Créer l\'événement'**
  String get feedCreateEvent;

  /// No description provided for @feedPleaseSelectAnAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez sélectionner une association'**
  String get feedPleaseSelectAnAssociation;

  /// No description provided for @feedReject.
  ///
  /// In fr, this message translates to:
  /// **'Rejeter'**
  String get feedReject;

  /// No description provided for @feedApprove.
  ///
  /// In fr, this message translates to:
  /// **'Approuver'**
  String get feedApprove;

  /// No description provided for @feedEnded.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get feedEnded;

  /// No description provided for @feedOngoing.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get feedOngoing;

  /// No description provided for @feedFilter.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer'**
  String get feedFilter;

  /// No description provided for @feedAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association'**
  String get feedAssociation;

  /// No description provided for @feedNewsType.
  ///
  /// In fr, this message translates to:
  /// **'Type d\'actualité'**
  String get feedNewsType;

  /// No description provided for @feedApply.
  ///
  /// In fr, this message translates to:
  /// **'Appliquer'**
  String get feedApply;

  /// No description provided for @feedNews.
  ///
  /// In fr, this message translates to:
  /// **'Actualités'**
  String get feedNews;

  /// No description provided for @feedAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administration'**
  String get feedAdmin;

  /// No description provided for @feedCreateAnEvent.
  ///
  /// In fr, this message translates to:
  /// **'Créer un événement'**
  String get feedCreateAnEvent;

  /// No description provided for @feedManageRequests.
  ///
  /// In fr, this message translates to:
  /// **'Demandes de publication'**
  String get feedManageRequests;

  /// No description provided for @feedNoNewsAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Aucune actualité disponible'**
  String get feedNoNewsAvailable;

  /// No description provided for @feedRefresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser'**
  String get feedRefresh;

  /// No description provided for @feedPleaseProvideASGExternalLink.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un lien externe pour le SG'**
  String get feedPleaseProvideASGExternalLink;

  /// No description provided for @feedPleaseProvideASGDate.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une date de SG'**
  String get feedPleaseProvideASGDate;

  /// Placeholder pour le temps restant avant le shotgun
  ///
  /// In fr, this message translates to:
  /// **'Shotgun {time}'**
  String feedShotgunIn(String time);

  /// Temps restant avant le vote
  ///
  /// In fr, this message translates to:
  /// **'Vote {time}'**
  String feedVoteIn(String time);

  /// No description provided for @feedCantOpenLink.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'ouvrir le lien'**
  String get feedCantOpenLink;

  /// No description provided for @feedGetReady.
  ///
  /// In fr, this message translates to:
  /// **'Prépare-toi !'**
  String get feedGetReady;

  /// No description provided for @eventActionCampaign.
  ///
  /// In fr, this message translates to:
  /// **'Tu peux voter'**
  String get eventActionCampaign;

  /// No description provided for @eventActionEvent.
  ///
  /// In fr, this message translates to:
  /// **'Tu es invité'**
  String get eventActionEvent;

  /// No description provided for @eventActionCampaignSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Votez maintenant'**
  String get eventActionCampaignSubtitle;

  /// No description provided for @eventActionEventSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Répondez à l\'invitation'**
  String get eventActionEventSubtitle;

  /// No description provided for @eventActionCampaignButton.
  ///
  /// In fr, this message translates to:
  /// **'Voter'**
  String get eventActionCampaignButton;

  /// No description provided for @eventActionEventButton.
  ///
  /// In fr, this message translates to:
  /// **'Réserver'**
  String get eventActionEventButton;

  /// No description provided for @eventActionCampaignValidated.
  ///
  /// In fr, this message translates to:
  /// **'J\'ai voté !'**
  String get eventActionCampaignValidated;

  /// No description provided for @eventActionEventValidated.
  ///
  /// In fr, this message translates to:
  /// **'Je viens !'**
  String get eventActionEventValidated;

  /// No description provided for @adminAccountTypes.
  ///
  /// In fr, this message translates to:
  /// **'Types de compte'**
  String get adminAccountTypes;

  /// No description provided for @adminAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get adminAdd;

  /// No description provided for @adminAddGroup.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un groupe'**
  String get adminAddGroup;

  /// No description provided for @adminAddMember.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un membre'**
  String get adminAddMember;

  /// No description provided for @adminAddedGroup.
  ///
  /// In fr, this message translates to:
  /// **'Groupe créé'**
  String get adminAddedGroup;

  /// No description provided for @adminAddedLoaner.
  ///
  /// In fr, this message translates to:
  /// **'Préteur ajouté'**
  String get adminAddedLoaner;

  /// No description provided for @adminAddedMember.
  ///
  /// In fr, this message translates to:
  /// **'Membre ajouté'**
  String get adminAddedMember;

  /// No description provided for @adminAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get adminAddingError;

  /// No description provided for @adminAddingMember.
  ///
  /// In fr, this message translates to:
  /// **'Ajout d\'un membre'**
  String get adminAddingMember;

  /// No description provided for @adminAddLoaningGroup.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un groupe de prêt'**
  String get adminAddLoaningGroup;

  /// No description provided for @adminAddSchool.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une école'**
  String get adminAddSchool;

  /// No description provided for @adminAddStructure.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une structure'**
  String get adminAddStructure;

  /// No description provided for @adminAddedSchool.
  ///
  /// In fr, this message translates to:
  /// **'École créée'**
  String get adminAddedSchool;

  /// No description provided for @adminAddedStructure.
  ///
  /// In fr, this message translates to:
  /// **'Structure ajoutée'**
  String get adminAddedStructure;

  /// No description provided for @adminEditedStructure.
  ///
  /// In fr, this message translates to:
  /// **'Structure modifiée'**
  String get adminEditedStructure;

  /// No description provided for @adminAdministration.
  ///
  /// In fr, this message translates to:
  /// **'Administration'**
  String get adminAdministration;

  /// No description provided for @adminAssociationMembership.
  ///
  /// In fr, this message translates to:
  /// **'Adhésion'**
  String get adminAssociationMembership;

  /// No description provided for @adminAssociationMembershipName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'adhésion'**
  String get adminAssociationMembershipName;

  /// No description provided for @adminAssociationsMemberships.
  ///
  /// In fr, this message translates to:
  /// **'Adhésions'**
  String get adminAssociationsMemberships;

  /// Displays the bank account holder's name
  ///
  /// In fr, this message translates to:
  /// **'Titulaire du compte bancaire : {bankAccountHolder}'**
  String adminBankAccountHolder(String bankAccountHolder);

  /// No description provided for @adminBankAccountHolderModified.
  ///
  /// In fr, this message translates to:
  /// **'Titulaire du compte bancaire modifié'**
  String get adminBankAccountHolderModified;

  /// No description provided for @adminBankDetails.
  ///
  /// In fr, this message translates to:
  /// **'Coordonnées bancaires'**
  String get adminBankDetails;

  /// No description provided for @adminBic.
  ///
  /// In fr, this message translates to:
  /// **'BIC'**
  String get adminBic;

  /// No description provided for @adminBicError.
  ///
  /// In fr, this message translates to:
  /// **'Le BIC doit faire 11 caractères'**
  String get adminBicError;

  /// No description provided for @adminCity.
  ///
  /// In fr, this message translates to:
  /// **'Ville'**
  String get adminCity;

  /// No description provided for @adminClearFilters.
  ///
  /// In fr, this message translates to:
  /// **'Effacer les filtres'**
  String get adminClearFilters;

  /// No description provided for @adminCountry.
  ///
  /// In fr, this message translates to:
  /// **'Pays'**
  String get adminCountry;

  /// No description provided for @adminCreateAssociationMembership.
  ///
  /// In fr, this message translates to:
  /// **'Créer une adhésion'**
  String get adminCreateAssociationMembership;

  /// No description provided for @adminCreatedAssociationMembership.
  ///
  /// In fr, this message translates to:
  /// **'Adhésion créée'**
  String get adminCreatedAssociationMembership;

  /// No description provided for @adminCreationError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la création'**
  String get adminCreationError;

  /// No description provided for @adminDateError.
  ///
  /// In fr, this message translates to:
  /// **'La date de début doit être avant la date de fin'**
  String get adminDateError;

  /// No description provided for @adminDefineAsBankAccountHolder.
  ///
  /// In fr, this message translates to:
  /// **'Définir comme titulaire du compte bancaire'**
  String get adminDefineAsBankAccountHolder;

  /// No description provided for @adminDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get adminDelete;

  /// No description provided for @adminDeleteAssociationMember.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le membre ?'**
  String get adminDeleteAssociationMember;

  /// No description provided for @adminDeleteAssociationMemberConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer ce membre ?'**
  String get adminDeleteAssociationMemberConfirmation;

  /// No description provided for @adminDeleteAssociationMembership.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'adhésion ?'**
  String get adminDeleteAssociationMembership;

  /// No description provided for @adminDeletedAssociationMembership.
  ///
  /// In fr, this message translates to:
  /// **'Adhésion supprimée'**
  String get adminDeletedAssociationMembership;

  /// No description provided for @adminDeleteGroup.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le groupe'**
  String get adminDeleteGroup;

  /// No description provided for @adminDeletedGroup.
  ///
  /// In fr, this message translates to:
  /// **'Groupe supprimé'**
  String get adminDeletedGroup;

  /// No description provided for @adminDeleteSchool.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'école ?'**
  String get adminDeleteSchool;

  /// No description provided for @adminDeletedSchool.
  ///
  /// In fr, this message translates to:
  /// **'École supprimée'**
  String get adminDeletedSchool;

  /// No description provided for @adminDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get adminDeleting;

  /// No description provided for @adminDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get adminDeletingError;

  /// No description provided for @adminDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get adminDescription;

  /// No description provided for @adminEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get adminEdit;

  /// No description provided for @adminEditStructure.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la structure'**
  String get adminEditStructure;

  /// No description provided for @adminEditMembership.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'adhésion'**
  String get adminEditMembership;

  /// No description provided for @adminEmptyDate.
  ///
  /// In fr, this message translates to:
  /// **'Date vide'**
  String get adminEmptyDate;

  /// No description provided for @adminEmptyFieldError.
  ///
  /// In fr, this message translates to:
  /// **'Le nom ne peut pas être vide'**
  String get adminEmptyFieldError;

  /// No description provided for @adminEmailFailed.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'envoyer un mail aux adresses suivantes'**
  String get adminEmailFailed;

  /// No description provided for @adminEmailRegex.
  ///
  /// In fr, this message translates to:
  /// **'Email Regex'**
  String get adminEmailRegex;

  /// No description provided for @adminEmptyUser.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateur vide'**
  String get adminEmptyUser;

  /// No description provided for @adminEndDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin'**
  String get adminEndDate;

  /// No description provided for @adminEndDateMaximal.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin maximale'**
  String get adminEndDateMaximal;

  /// No description provided for @adminEndDateMinimal.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin minimale'**
  String get adminEndDateMinimal;

  /// No description provided for @adminError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get adminError;

  /// No description provided for @adminFilters.
  ///
  /// In fr, this message translates to:
  /// **'Filtres'**
  String get adminFilters;

  /// No description provided for @adminGroup.
  ///
  /// In fr, this message translates to:
  /// **'Groupe'**
  String get adminGroup;

  /// No description provided for @adminGroups.
  ///
  /// In fr, this message translates to:
  /// **'Groupes'**
  String get adminGroups;

  /// No description provided for @adminIban.
  ///
  /// In fr, this message translates to:
  /// **'IBAN'**
  String get adminIban;

  /// No description provided for @adminIbanError.
  ///
  /// In fr, this message translates to:
  /// **'L\'IBAN doit faire 27 caractères'**
  String get adminIbanError;

  /// No description provided for @adminLoaningGroup.
  ///
  /// In fr, this message translates to:
  /// **'Groupe de prêt'**
  String get adminLoaningGroup;

  /// No description provided for @adminLooking.
  ///
  /// In fr, this message translates to:
  /// **'Recherche'**
  String get adminLooking;

  /// No description provided for @adminManager.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur de la structure'**
  String get adminManager;

  /// No description provided for @adminMaximum.
  ///
  /// In fr, this message translates to:
  /// **'Maximum'**
  String get adminMaximum;

  /// No description provided for @adminMembers.
  ///
  /// In fr, this message translates to:
  /// **'Membres'**
  String get adminMembers;

  /// No description provided for @adminMembershipAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout (surement dû à une superposition de dates)'**
  String get adminMembershipAddingError;

  /// No description provided for @adminMemberships.
  ///
  /// In fr, this message translates to:
  /// **'Adhésions'**
  String get adminMemberships;

  /// No description provided for @adminMembershipUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification (surement dû à une superposition de dates)'**
  String get adminMembershipUpdatingError;

  /// No description provided for @adminMinimum.
  ///
  /// In fr, this message translates to:
  /// **'Minimum'**
  String get adminMinimum;

  /// No description provided for @adminModifyModuleVisibility.
  ///
  /// In fr, this message translates to:
  /// **'Visibilité des modules'**
  String get adminModifyModuleVisibility;

  /// No description provided for @adminName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get adminName;

  /// No description provided for @adminNoGroup.
  ///
  /// In fr, this message translates to:
  /// **'Aucun groupe'**
  String get adminNoGroup;

  /// No description provided for @adminNoManager.
  ///
  /// In fr, this message translates to:
  /// **'Aucun manager n\'est sélectionné'**
  String get adminNoManager;

  /// No description provided for @adminNoMember.
  ///
  /// In fr, this message translates to:
  /// **'Aucun membre'**
  String get adminNoMember;

  /// No description provided for @adminNoMoreLoaner.
  ///
  /// In fr, this message translates to:
  /// **'Aucun prêteur n\'est disponible'**
  String get adminNoMoreLoaner;

  /// No description provided for @adminNoSchool.
  ///
  /// In fr, this message translates to:
  /// **'Sans école'**
  String get adminNoSchool;

  /// No description provided for @adminRemoveGroupMember.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le membre du groupe ?'**
  String get adminRemoveGroupMember;

  /// No description provided for @adminResearch.
  ///
  /// In fr, this message translates to:
  /// **'Recherche'**
  String get adminResearch;

  /// No description provided for @adminSchools.
  ///
  /// In fr, this message translates to:
  /// **'Écoles'**
  String get adminSchools;

  /// No description provided for @adminShortId.
  ///
  /// In fr, this message translates to:
  /// **'Short ID (3 lettres)'**
  String get adminShortId;

  /// No description provided for @adminShortIdError.
  ///
  /// In fr, this message translates to:
  /// **'Le short ID doit faire 3 caractères'**
  String get adminShortIdError;

  /// No description provided for @adminSiegeAddress.
  ///
  /// In fr, this message translates to:
  /// **'Adresse du siège'**
  String get adminSiegeAddress;

  /// No description provided for @adminSiret.
  ///
  /// In fr, this message translates to:
  /// **'SIRET'**
  String get adminSiret;

  /// No description provided for @adminSiretError.
  ///
  /// In fr, this message translates to:
  /// **'SIRET must be 14 digits'**
  String get adminSiretError;

  /// No description provided for @adminStreet.
  ///
  /// In fr, this message translates to:
  /// **'Numéro et rue'**
  String get adminStreet;

  /// No description provided for @adminStructures.
  ///
  /// In fr, this message translates to:
  /// **'Structures'**
  String get adminStructures;

  /// No description provided for @adminStartDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get adminStartDate;

  /// No description provided for @adminStartDateMaximal.
  ///
  /// In fr, this message translates to:
  /// **'Date de début maximale'**
  String get adminStartDateMaximal;

  /// No description provided for @adminStartDateMinimal.
  ///
  /// In fr, this message translates to:
  /// **'Date de début minimale'**
  String get adminStartDateMinimal;

  /// No description provided for @adminUndefinedBankAccountHolder.
  ///
  /// In fr, this message translates to:
  /// **'Titulaire du compte bancaire non défini'**
  String get adminUndefinedBankAccountHolder;

  /// No description provided for @adminUpdatedAssociationMembership.
  ///
  /// In fr, this message translates to:
  /// **'Adhésion modifiée'**
  String get adminUpdatedAssociationMembership;

  /// No description provided for @adminUpdatedGroup.
  ///
  /// In fr, this message translates to:
  /// **'Groupe modifié'**
  String get adminUpdatedGroup;

  /// No description provided for @adminUpdatedMembership.
  ///
  /// In fr, this message translates to:
  /// **'Adhésion modifiée'**
  String get adminUpdatedMembership;

  /// No description provided for @adminUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get adminUpdatingError;

  /// No description provided for @adminUser.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateur'**
  String get adminUser;

  /// No description provided for @adminValidateFilters.
  ///
  /// In fr, this message translates to:
  /// **'Valider les filtres'**
  String get adminValidateFilters;

  /// No description provided for @adminVisibilities.
  ///
  /// In fr, this message translates to:
  /// **'Visibilités'**
  String get adminVisibilities;

  /// No description provided for @adminZipcode.
  ///
  /// In fr, this message translates to:
  /// **'Code postal'**
  String get adminZipcode;

  /// No description provided for @adminGroupNotification.
  ///
  /// In fr, this message translates to:
  /// **'Notification de groupe'**
  String get adminGroupNotification;

  /// Notifie les membres du groupe sélectionné
  ///
  /// In fr, this message translates to:
  /// **'Notifier le groupe {groupName}'**
  String adminNotifyGroup(String groupName);

  /// No description provided for @adminTitle.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get adminTitle;

  /// No description provided for @adminContent.
  ///
  /// In fr, this message translates to:
  /// **'Contenu'**
  String get adminContent;

  /// No description provided for @adminSend.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get adminSend;

  /// No description provided for @adminNotificationSent.
  ///
  /// In fr, this message translates to:
  /// **'Notification envoyée'**
  String get adminNotificationSent;

  /// No description provided for @adminFailedToSendNotification.
  ///
  /// In fr, this message translates to:
  /// **'Échec de l\'envoi de la notification'**
  String get adminFailedToSendNotification;

  /// No description provided for @adminGroupsManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des groupes'**
  String get adminGroupsManagement;

  /// No description provided for @adminEditGroup.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le groupe'**
  String get adminEditGroup;

  /// No description provided for @adminManageMembers.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les membres'**
  String get adminManageMembers;

  /// No description provided for @adminDeleteGroupConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer ce groupe ?'**
  String get adminDeleteGroupConfirmation;

  /// No description provided for @adminFailedToDeleteGroup.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la suppression du groupe'**
  String get adminFailedToDeleteGroup;

  /// No description provided for @adminUsersAndGroups.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateurs et groupes'**
  String get adminUsersAndGroups;

  /// No description provided for @adminUsersManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des utilisateurs'**
  String get adminUsersManagement;

  /// No description provided for @adminUsersManagementDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les utilisateurs de l\'application'**
  String get adminUsersManagementDescription;

  /// No description provided for @adminManageUserGroups.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les groupes d\'utilisateurs'**
  String get adminManageUserGroups;

  /// No description provided for @adminSendNotificationToGroup.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer une notification à un groupe'**
  String get adminSendNotificationToGroup;

  /// No description provided for @adminPaiementModule.
  ///
  /// In fr, this message translates to:
  /// **'Module de paiement'**
  String get adminPaiementModule;

  /// No description provided for @adminPaiement.
  ///
  /// In fr, this message translates to:
  /// **'Paiement'**
  String get adminPaiement;

  /// No description provided for @adminManagePaiementStructures.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les structures du module de paiement'**
  String get adminManagePaiementStructures;

  /// No description provided for @adminManageUsersAssociationMemberships.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les adhésions des utilisateurs'**
  String get adminManageUsersAssociationMemberships;

  /// No description provided for @adminAssociationMembershipsManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des adhésions'**
  String get adminAssociationMembershipsManagement;

  /// No description provided for @adminChooseGroupManager.
  ///
  /// In fr, this message translates to:
  /// **'Groupe gestionnaire de l\'adhésion'**
  String get adminChooseGroupManager;

  /// No description provided for @adminSelectManager.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner un gestionnaire'**
  String get adminSelectManager;

  /// No description provided for @adminImportList.
  ///
  /// In fr, this message translates to:
  /// **'Importer une liste'**
  String get adminImportList;

  /// No description provided for @adminImportUsersDescription.
  ///
  /// In fr, this message translates to:
  /// **'Importer des utilisateurs depuis un fichier CSV. Le fichier CSV doit contenir une adresse email par ligne.'**
  String get adminImportUsersDescription;

  /// No description provided for @adminFailedToInviteUsers.
  ///
  /// In fr, this message translates to:
  /// **'Échec de l\'invitation des utilisateurs'**
  String get adminFailedToInviteUsers;

  /// No description provided for @adminDeleteUsers.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer des utilisateurs'**
  String get adminDeleteUsers;

  /// No description provided for @adminAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Admin'**
  String get adminAdmin;

  /// No description provided for @adminAssociations.
  ///
  /// In fr, this message translates to:
  /// **'Associations'**
  String get adminAssociations;

  /// No description provided for @adminManageAssociations.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les associations'**
  String get adminManageAssociations;

  /// No description provided for @adminAddAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une association'**
  String get adminAddAssociation;

  /// No description provided for @adminAssociationName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'association'**
  String get adminAssociationName;

  /// No description provided for @adminSelectGroupAssociationManager.
  ///
  /// In fr, this message translates to:
  /// **'Séléctionner roupe gestionnaire de l\'association'**
  String get adminSelectGroupAssociationManager;

  /// Modifier les informations de l'association
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'association : {associationName}'**
  String adminEditAssociation(String associationName);

  /// Groupe qui gère l'association
  ///
  /// In fr, this message translates to:
  /// **'Groupe gestionnaire : {groupName}'**
  String adminManagerGroup(String groupName);

  /// No description provided for @adminAssociationCreated.
  ///
  /// In fr, this message translates to:
  /// **'Association créée'**
  String get adminAssociationCreated;

  /// No description provided for @adminAssociationUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Association mise à jour'**
  String get adminAssociationUpdated;

  /// No description provided for @adminAssociationCreationError.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la création de l\'association'**
  String get adminAssociationCreationError;

  /// No description provided for @adminAssociationUpdateError.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la mise à jour de l\'association'**
  String get adminAssociationUpdateError;

  /// No description provided for @adminInvite.
  ///
  /// In fr, this message translates to:
  /// **'Inviter'**
  String get adminInvite;

  /// No description provided for @adminInvitedUsers.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateurs invités'**
  String get adminInvitedUsers;

  /// No description provided for @adminInviteUsers.
  ///
  /// In fr, this message translates to:
  /// **'Inviter des utilisateurs'**
  String get adminInviteUsers;

  /// Text with the number of users in the CSV file
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, zero {Aucun utilisateur} one {{count} utilisateur} other {{count} utilisateurs}} dans le fichier CSV'**
  String adminInviteUsersCounter(int count);

  /// No description provided for @adminUpdatedAssociationLogo.
  ///
  /// In fr, this message translates to:
  /// **'Logo de l\'association mis à jour'**
  String get adminUpdatedAssociationLogo;

  /// No description provided for @adminTooHeavyLogo.
  ///
  /// In fr, this message translates to:
  /// **'Le logo de l\'association est trop lourd, il doit faire moins de 4 Mo'**
  String get adminTooHeavyLogo;

  /// No description provided for @adminFailedToUpdateAssociationLogo.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la mise à jour du logo de l\'association'**
  String get adminFailedToUpdateAssociationLogo;

  /// No description provided for @adminChooseGroup.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un groupe'**
  String get adminChooseGroup;

  /// No description provided for @adminChooseAssociationManagerGroup.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un groupe gestionnaire pour l\'association'**
  String get adminChooseAssociationManagerGroup;

  /// No description provided for @advertAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get advertAdd;

  /// No description provided for @advertAddedAdvert.
  ///
  /// In fr, this message translates to:
  /// **'Annonce publiée'**
  String get advertAddedAdvert;

  /// No description provided for @advertAddedAnnouncer.
  ///
  /// In fr, this message translates to:
  /// **'Annonceur ajouté'**
  String get advertAddedAnnouncer;

  /// No description provided for @advertAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get advertAddingError;

  /// No description provided for @advertAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Admin'**
  String get advertAdmin;

  /// No description provided for @advertAdvert.
  ///
  /// In fr, this message translates to:
  /// **'Annonce'**
  String get advertAdvert;

  /// No description provided for @advertChoosingAnnouncer.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir un annonceur'**
  String get advertChoosingAnnouncer;

  /// No description provided for @advertChoosingPoster.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir une image'**
  String get advertChoosingPoster;

  /// No description provided for @advertContent.
  ///
  /// In fr, this message translates to:
  /// **'Contenu'**
  String get advertContent;

  /// No description provided for @advertDeleteAdvert.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'annonce'**
  String get advertDeleteAdvert;

  /// No description provided for @advertDeleteAnnouncer.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'annonceur ?'**
  String get advertDeleteAnnouncer;

  /// No description provided for @advertDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get advertDeleting;

  /// No description provided for @advertEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get advertEdit;

  /// No description provided for @advertEditedAdvert.
  ///
  /// In fr, this message translates to:
  /// **'Annonce modifiée'**
  String get advertEditedAdvert;

  /// No description provided for @advertEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get advertEditingError;

  /// No description provided for @advertGroupAdvert.
  ///
  /// In fr, this message translates to:
  /// **'Groupe'**
  String get advertGroupAdvert;

  /// No description provided for @advertIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Champs incorrects ou manquants'**
  String get advertIncorrectOrMissingFields;

  /// No description provided for @advertInvalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre'**
  String get advertInvalidNumber;

  /// No description provided for @advertManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion'**
  String get advertManagement;

  /// No description provided for @advertModifyAnnouncingGroup.
  ///
  /// In fr, this message translates to:
  /// **'Modifier un groupe d\'annonce'**
  String get advertModifyAnnouncingGroup;

  /// No description provided for @advertNoMoreAnnouncer.
  ///
  /// In fr, this message translates to:
  /// **'Aucun annonceur n\'est disponible'**
  String get advertNoMoreAnnouncer;

  /// No description provided for @advertNoValue.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une valeur'**
  String get advertNoValue;

  /// No description provided for @advertPositiveNumber.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre positif'**
  String get advertPositiveNumber;

  /// No description provided for @advertPublishToFeed.
  ///
  /// In fr, this message translates to:
  /// **'Publier dans le feed'**
  String get advertPublishToFeed;

  /// No description provided for @advertRemovedAnnouncer.
  ///
  /// In fr, this message translates to:
  /// **'Annonceur supprimé'**
  String get advertRemovedAnnouncer;

  /// No description provided for @advertRemovingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get advertRemovingError;

  /// No description provided for @advertTags.
  ///
  /// In fr, this message translates to:
  /// **'Tags'**
  String get advertTags;

  /// No description provided for @advertTitle.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get advertTitle;

  /// No description provided for @advertMonthJan.
  ///
  /// In fr, this message translates to:
  /// **'Janv'**
  String get advertMonthJan;

  /// No description provided for @advertMonthFeb.
  ///
  /// In fr, this message translates to:
  /// **'Févr.'**
  String get advertMonthFeb;

  /// No description provided for @advertMonthMar.
  ///
  /// In fr, this message translates to:
  /// **'Mars'**
  String get advertMonthMar;

  /// No description provided for @advertMonthApr.
  ///
  /// In fr, this message translates to:
  /// **'Avr.'**
  String get advertMonthApr;

  /// No description provided for @advertMonthMay.
  ///
  /// In fr, this message translates to:
  /// **'Mai'**
  String get advertMonthMay;

  /// No description provided for @advertMonthJun.
  ///
  /// In fr, this message translates to:
  /// **'Juin'**
  String get advertMonthJun;

  /// No description provided for @advertMonthJul.
  ///
  /// In fr, this message translates to:
  /// **'Juill.'**
  String get advertMonthJul;

  /// No description provided for @advertMonthAug.
  ///
  /// In fr, this message translates to:
  /// **'Août'**
  String get advertMonthAug;

  /// No description provided for @advertMonthSep.
  ///
  /// In fr, this message translates to:
  /// **'Sept.'**
  String get advertMonthSep;

  /// No description provided for @advertMonthOct.
  ///
  /// In fr, this message translates to:
  /// **'Oct.'**
  String get advertMonthOct;

  /// No description provided for @advertMonthNov.
  ///
  /// In fr, this message translates to:
  /// **'Nov.'**
  String get advertMonthNov;

  /// No description provided for @advertMonthDec.
  ///
  /// In fr, this message translates to:
  /// **'Déc.'**
  String get advertMonthDec;

  /// No description provided for @amapAccounts.
  ///
  /// In fr, this message translates to:
  /// **'Comptes'**
  String get amapAccounts;

  /// No description provided for @amapAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get amapAdd;

  /// No description provided for @amapAddDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une livraison'**
  String get amapAddDelivery;

  /// No description provided for @amapAddedCommand.
  ///
  /// In fr, this message translates to:
  /// **'Commande ajoutée'**
  String get amapAddedCommand;

  /// No description provided for @amapAddedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande ajoutée'**
  String get amapAddedOrder;

  /// No description provided for @amapAddedProduct.
  ///
  /// In fr, this message translates to:
  /// **'Produit ajouté'**
  String get amapAddedProduct;

  /// No description provided for @amapAddedUser.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateur ajouté'**
  String get amapAddedUser;

  /// No description provided for @amapAddProduct.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un produit'**
  String get amapAddProduct;

  /// No description provided for @amapAddUser.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un utilisateur'**
  String get amapAddUser;

  /// No description provided for @amapAddingACommand.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une commande'**
  String get amapAddingACommand;

  /// No description provided for @amapAddingCommand.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter la commande'**
  String get amapAddingCommand;

  /// No description provided for @amapAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get amapAddingError;

  /// No description provided for @amapAddingProduct.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un produit'**
  String get amapAddingProduct;

  /// No description provided for @amapAddOrder.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une commande'**
  String get amapAddOrder;

  /// No description provided for @amapAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Admin'**
  String get amapAdmin;

  /// No description provided for @amapAlreadyExistCommand.
  ///
  /// In fr, this message translates to:
  /// **'Il existe déjà une commande à cette date'**
  String get amapAlreadyExistCommand;

  /// No description provided for @amapAmap.
  ///
  /// In fr, this message translates to:
  /// **'Amap'**
  String get amapAmap;

  /// No description provided for @amapAmount.
  ///
  /// In fr, this message translates to:
  /// **'Solde'**
  String get amapAmount;

  /// No description provided for @amapArchive.
  ///
  /// In fr, this message translates to:
  /// **'Archiver'**
  String get amapArchive;

  /// No description provided for @amapArchiveDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Archiver'**
  String get amapArchiveDelivery;

  /// No description provided for @amapArchivingDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Archivage de la livraison'**
  String get amapArchivingDelivery;

  /// No description provided for @amapCategory.
  ///
  /// In fr, this message translates to:
  /// **'Catégorie'**
  String get amapCategory;

  /// No description provided for @amapCloseDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Verrouiller'**
  String get amapCloseDelivery;

  /// No description provided for @amapCommandDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de la commande'**
  String get amapCommandDate;

  /// No description provided for @amapCommandProducts.
  ///
  /// In fr, this message translates to:
  /// **'Produits de la commande'**
  String get amapCommandProducts;

  /// No description provided for @amapConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get amapConfirm;

  /// No description provided for @amapContact.
  ///
  /// In fr, this message translates to:
  /// **'Contacts associatifs '**
  String get amapContact;

  /// No description provided for @amapCreateCategory.
  ///
  /// In fr, this message translates to:
  /// **'Créer une catégorie'**
  String get amapCreateCategory;

  /// No description provided for @amapDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get amapDelete;

  /// No description provided for @amapDeleteDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la livraison ?'**
  String get amapDeleteDelivery;

  /// No description provided for @amapDeleteDeliveryDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer cette livraison ?'**
  String get amapDeleteDeliveryDescription;

  /// No description provided for @amapDeletedDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Livraison supprimée'**
  String get amapDeletedDelivery;

  /// No description provided for @amapDeletedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande supprimée'**
  String get amapDeletedOrder;

  /// No description provided for @amapDeletedProduct.
  ///
  /// In fr, this message translates to:
  /// **'Produit supprimé'**
  String get amapDeletedProduct;

  /// No description provided for @amapDeleteProduct.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le produit ?'**
  String get amapDeleteProduct;

  /// No description provided for @amapDeleteProductDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer ce produit ?'**
  String get amapDeleteProductDescription;

  /// No description provided for @amapDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get amapDeleting;

  /// No description provided for @amapDeletingDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la livraison ?'**
  String get amapDeletingDelivery;

  /// No description provided for @amapDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get amapDeletingError;

  /// No description provided for @amapDeletingOrder.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la commande ?'**
  String get amapDeletingOrder;

  /// No description provided for @amapDeletingProduct.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le produit ?'**
  String get amapDeletingProduct;

  /// No description provided for @amapDeliver.
  ///
  /// In fr, this message translates to:
  /// **'Livraison teminée ?'**
  String get amapDeliver;

  /// No description provided for @amapDeliveries.
  ///
  /// In fr, this message translates to:
  /// **'Livraisons'**
  String get amapDeliveries;

  /// No description provided for @amapDeliveringDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les commandes sont livrées ?'**
  String get amapDeliveringDelivery;

  /// No description provided for @amapDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Livraison'**
  String get amapDelivery;

  /// No description provided for @amapDeliveryArchived.
  ///
  /// In fr, this message translates to:
  /// **'Livraison archivée'**
  String get amapDeliveryArchived;

  /// No description provided for @amapDeliveryDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de livraison'**
  String get amapDeliveryDate;

  /// No description provided for @amapDeliveryDelivered.
  ///
  /// In fr, this message translates to:
  /// **'Livraison effectuée'**
  String get amapDeliveryDelivered;

  /// No description provided for @amapDeliveryHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique des livraisons'**
  String get amapDeliveryHistory;

  /// No description provided for @amapDeliveryList.
  ///
  /// In fr, this message translates to:
  /// **'Liste des livraisons'**
  String get amapDeliveryList;

  /// No description provided for @amapDeliveryLocked.
  ///
  /// In fr, this message translates to:
  /// **'Livraison verrouillée'**
  String get amapDeliveryLocked;

  /// No description provided for @amapDeliveryOn.
  ///
  /// In fr, this message translates to:
  /// **'Livraison le'**
  String get amapDeliveryOn;

  /// No description provided for @amapDeliveryOpened.
  ///
  /// In fr, this message translates to:
  /// **'Livraison ouverte'**
  String get amapDeliveryOpened;

  /// No description provided for @amapDeliveryNotArchived.
  ///
  /// In fr, this message translates to:
  /// **'Livraison non archivée'**
  String get amapDeliveryNotArchived;

  /// No description provided for @amapDeliveryNotLocked.
  ///
  /// In fr, this message translates to:
  /// **'Livraison non verrouillée'**
  String get amapDeliveryNotLocked;

  /// No description provided for @amapDeliveryNotDelivered.
  ///
  /// In fr, this message translates to:
  /// **'Livraison non effectuée'**
  String get amapDeliveryNotDelivered;

  /// No description provided for @amapDeliveryNotOpened.
  ///
  /// In fr, this message translates to:
  /// **'Livraison non ouverte'**
  String get amapDeliveryNotOpened;

  /// No description provided for @amapEditDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la livraison'**
  String get amapEditDelivery;

  /// No description provided for @amapEditedCommand.
  ///
  /// In fr, this message translates to:
  /// **'Commande modifiée'**
  String get amapEditedCommand;

  /// No description provided for @amapEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get amapEditingError;

  /// No description provided for @amapEditProduct.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le produit'**
  String get amapEditProduct;

  /// No description provided for @amapEndingDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Fin de la livraison'**
  String get amapEndingDelivery;

  /// No description provided for @amapError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get amapError;

  /// No description provided for @amapErrorLink.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ouverture du lien'**
  String get amapErrorLink;

  /// No description provided for @amapErrorLoadingUser.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des utilisateurs'**
  String get amapErrorLoadingUser;

  /// No description provided for @amapEvening.
  ///
  /// In fr, this message translates to:
  /// **'Soir'**
  String get amapEvening;

  /// No description provided for @amapExpectingNumber.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre'**
  String get amapExpectingNumber;

  /// No description provided for @amapFillField.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez remplir ce champ'**
  String get amapFillField;

  /// No description provided for @amapHandlingAccount.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les comptes'**
  String get amapHandlingAccount;

  /// No description provided for @amapLoading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement...'**
  String get amapLoading;

  /// No description provided for @amapLoadingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement'**
  String get amapLoadingError;

  /// No description provided for @amapLock.
  ///
  /// In fr, this message translates to:
  /// **'Verrouiller'**
  String get amapLock;

  /// No description provided for @amapLocked.
  ///
  /// In fr, this message translates to:
  /// **'Verrouillée'**
  String get amapLocked;

  /// No description provided for @amapLockedDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Livraison verrouillée'**
  String get amapLockedDelivery;

  /// No description provided for @amapLockedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande verrouillée'**
  String get amapLockedOrder;

  /// No description provided for @amapLooking.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get amapLooking;

  /// No description provided for @amapLockingDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Verrouiller la livraison ?'**
  String get amapLockingDelivery;

  /// No description provided for @amapMidDay.
  ///
  /// In fr, this message translates to:
  /// **'Midi'**
  String get amapMidDay;

  /// No description provided for @amapMyOrders.
  ///
  /// In fr, this message translates to:
  /// **'Mes commandes'**
  String get amapMyOrders;

  /// No description provided for @amapName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get amapName;

  /// No description provided for @amapNextStep.
  ///
  /// In fr, this message translates to:
  /// **'Étape suivante'**
  String get amapNextStep;

  /// No description provided for @amapNoProduct.
  ///
  /// In fr, this message translates to:
  /// **'Pas de produit'**
  String get amapNoProduct;

  /// No description provided for @amapNoCurrentOrder.
  ///
  /// In fr, this message translates to:
  /// **'Pas de commande en cours'**
  String get amapNoCurrentOrder;

  /// No description provided for @amapNoMoney.
  ///
  /// In fr, this message translates to:
  /// **'Pas assez d\'argent'**
  String get amapNoMoney;

  /// No description provided for @amapNoOpennedDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Pas de livraison ouverte'**
  String get amapNoOpennedDelivery;

  /// No description provided for @amapNoOrder.
  ///
  /// In fr, this message translates to:
  /// **'Pas de commande'**
  String get amapNoOrder;

  /// No description provided for @amapNoSelectedDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Pas de livraison sélectionnée'**
  String get amapNoSelectedDelivery;

  /// No description provided for @amapNotEnoughMoney.
  ///
  /// In fr, this message translates to:
  /// **'Pas assez d\'argent'**
  String get amapNotEnoughMoney;

  /// No description provided for @amapNotPlannedDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Pas de livraison planifiée'**
  String get amapNotPlannedDelivery;

  /// No description provided for @amapOneOrder.
  ///
  /// In fr, this message translates to:
  /// **'commande'**
  String get amapOneOrder;

  /// No description provided for @amapOpenDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir'**
  String get amapOpenDelivery;

  /// No description provided for @amapOpened.
  ///
  /// In fr, this message translates to:
  /// **'Ouverte'**
  String get amapOpened;

  /// No description provided for @amapOpenningDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir la livraison ?'**
  String get amapOpenningDelivery;

  /// No description provided for @amapOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commander'**
  String get amapOrder;

  /// No description provided for @amapOrders.
  ///
  /// In fr, this message translates to:
  /// **'Commandes'**
  String get amapOrders;

  /// No description provided for @amapPickChooseCategory.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une valeur ou choisir une catégorie existante'**
  String get amapPickChooseCategory;

  /// No description provided for @amapPickDeliveryMoment.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un moment de livraison'**
  String get amapPickDeliveryMoment;

  /// No description provided for @amapPresentation.
  ///
  /// In fr, this message translates to:
  /// **'Présentation'**
  String get amapPresentation;

  /// No description provided for @amapPresentation1.
  ///
  /// In fr, this message translates to:
  /// **'L\'AMAP (association pour le maintien d\'une agriculture paysanne) est un service proposé par l\'association Planet&Co de l\'ECL. Vous pouvez ainsi recevoir des produits (paniers de fruits et légumes, jus, confitures...) directement sur le campus !\n\nLes commandes doivent être passées avant le vendredi 21h et sont livrées sur le campus le mardi de 13h à 13h45 (ou de 18h15 à 18h30 si vous ne pouvez pas passer le midi) dans le hall du M16.\n\nVous ne pouvez commander que si votre solde le permet. Vous pouvez recharger votre solde via la collecte Lydia ou bien avec un chèque que vous pouvez nous transmettre lors des permanences.\n\nLien vers la collecte Lydia pour le rechargement : '**
  String get amapPresentation1;

  /// No description provided for @amapPresentation2.
  ///
  /// In fr, this message translates to:
  /// **'\n\nN\'hésitez pas à nous contacter en cas de problème !'**
  String get amapPresentation2;

  /// No description provided for @amapPrice.
  ///
  /// In fr, this message translates to:
  /// **'Prix'**
  String get amapPrice;

  /// No description provided for @amapProduct.
  ///
  /// In fr, this message translates to:
  /// **'produit'**
  String get amapProduct;

  /// No description provided for @amapProducts.
  ///
  /// In fr, this message translates to:
  /// **'Produits'**
  String get amapProducts;

  /// No description provided for @amapProductInDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Produit dans une livraison non terminée'**
  String get amapProductInDelivery;

  /// No description provided for @amapQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get amapQuantity;

  /// No description provided for @amapRequiredDate.
  ///
  /// In fr, this message translates to:
  /// **'La date est requise'**
  String get amapRequiredDate;

  /// No description provided for @amapSeeMore.
  ///
  /// In fr, this message translates to:
  /// **'Voir plus'**
  String get amapSeeMore;

  /// No description provided for @amapThe.
  ///
  /// In fr, this message translates to:
  /// **'Le'**
  String get amapThe;

  /// No description provided for @amapUnlock.
  ///
  /// In fr, this message translates to:
  /// **'Dévérouiller'**
  String get amapUnlock;

  /// No description provided for @amapUnlockedDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Livraison dévérouillée'**
  String get amapUnlockedDelivery;

  /// No description provided for @amapUnlockingDelivery.
  ///
  /// In fr, this message translates to:
  /// **'Dévérouiller la livraison ?'**
  String get amapUnlockingDelivery;

  /// No description provided for @amapUpdate.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get amapUpdate;

  /// No description provided for @amapUpdatedAmount.
  ///
  /// In fr, this message translates to:
  /// **'Solde modifié'**
  String get amapUpdatedAmount;

  /// No description provided for @amapUpdatedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande modifiée'**
  String get amapUpdatedOrder;

  /// No description provided for @amapUpdatedProduct.
  ///
  /// In fr, this message translates to:
  /// **'Produit modifié'**
  String get amapUpdatedProduct;

  /// No description provided for @amapUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Echec de la modification'**
  String get amapUpdatingError;

  /// No description provided for @amapUsersNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun utilisateur trouvé'**
  String get amapUsersNotFound;

  /// No description provided for @amapWaiting.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get amapWaiting;

  /// No description provided for @bookingAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get bookingAdd;

  /// No description provided for @bookingAddBookingPage.
  ///
  /// In fr, this message translates to:
  /// **'Demande'**
  String get bookingAddBookingPage;

  /// No description provided for @bookingAddRoom.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une salle'**
  String get bookingAddRoom;

  /// No description provided for @bookingAddBooking.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une réservation'**
  String get bookingAddBooking;

  /// No description provided for @bookingAddedBooking.
  ///
  /// In fr, this message translates to:
  /// **'Demande ajoutée'**
  String get bookingAddedBooking;

  /// No description provided for @bookingAddedRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle ajoutée'**
  String get bookingAddedRoom;

  /// No description provided for @bookingAddedManager.
  ///
  /// In fr, this message translates to:
  /// **'Gestionnaire ajouté'**
  String get bookingAddedManager;

  /// No description provided for @bookingAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get bookingAddingError;

  /// No description provided for @bookingAddManager.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un gestionnaire'**
  String get bookingAddManager;

  /// No description provided for @bookingAdminPage.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur'**
  String get bookingAdminPage;

  /// No description provided for @bookingAllDay.
  ///
  /// In fr, this message translates to:
  /// **'Toute la journée'**
  String get bookingAllDay;

  /// No description provided for @bookingBookedFor.
  ///
  /// In fr, this message translates to:
  /// **'Réservé pour'**
  String get bookingBookedFor;

  /// No description provided for @bookingBooking.
  ///
  /// In fr, this message translates to:
  /// **'Réservation'**
  String get bookingBooking;

  /// No description provided for @bookingBookingCreated.
  ///
  /// In fr, this message translates to:
  /// **'Réservation créée'**
  String get bookingBookingCreated;

  /// No description provided for @bookingBookingDemand.
  ///
  /// In fr, this message translates to:
  /// **'Demande de réservation'**
  String get bookingBookingDemand;

  /// No description provided for @bookingBookingNote.
  ///
  /// In fr, this message translates to:
  /// **'Note de la réservation'**
  String get bookingBookingNote;

  /// No description provided for @bookingBookingPage.
  ///
  /// In fr, this message translates to:
  /// **'Réservation'**
  String get bookingBookingPage;

  /// No description provided for @bookingBookingReason.
  ///
  /// In fr, this message translates to:
  /// **'Motif de la réservation'**
  String get bookingBookingReason;

  /// No description provided for @bookingBy.
  ///
  /// In fr, this message translates to:
  /// **'par'**
  String get bookingBy;

  /// No description provided for @bookingConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get bookingConfirm;

  /// No description provided for @bookingConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation'**
  String get bookingConfirmation;

  /// No description provided for @bookingConfirmBooking.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer la réservation ?'**
  String get bookingConfirmBooking;

  /// No description provided for @bookingConfirmed.
  ///
  /// In fr, this message translates to:
  /// **'Validée'**
  String get bookingConfirmed;

  /// No description provided for @bookingDates.
  ///
  /// In fr, this message translates to:
  /// **'Dates'**
  String get bookingDates;

  /// No description provided for @bookingDecline.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get bookingDecline;

  /// No description provided for @bookingDeclineBooking.
  ///
  /// In fr, this message translates to:
  /// **'Refuser la réservation ?'**
  String get bookingDeclineBooking;

  /// No description provided for @bookingDeclined.
  ///
  /// In fr, this message translates to:
  /// **'Refusée'**
  String get bookingDeclined;

  /// No description provided for @bookingDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get bookingDelete;

  /// No description provided for @bookingDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get bookingDeleting;

  /// No description provided for @bookingDeleteBooking.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get bookingDeleteBooking;

  /// No description provided for @bookingDeleteBookingConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer cette réservation ?'**
  String get bookingDeleteBookingConfirmation;

  /// No description provided for @bookingDeletedBooking.
  ///
  /// In fr, this message translates to:
  /// **'Réservation supprimée'**
  String get bookingDeletedBooking;

  /// No description provided for @bookingDeletedRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle supprimée'**
  String get bookingDeletedRoom;

  /// No description provided for @bookingDeletedManager.
  ///
  /// In fr, this message translates to:
  /// **'Gestionnaire supprimé'**
  String get bookingDeletedManager;

  /// No description provided for @bookingDeleteRoomConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer cette salle ?\n\nLa salle ne doit avoir aucune réservation en cours ou à venir pour être supprimée'**
  String get bookingDeleteRoomConfirmation;

  /// No description provided for @bookingDeleteManagerConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer ce gestionnaire ?\n\nLe gestionnaire ne doit être associé à aucune salle pour pouvoir être supprimé'**
  String get bookingDeleteManagerConfirmation;

  /// No description provided for @bookingDeletingBooking.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la réservation ?'**
  String get bookingDeletingBooking;

  /// No description provided for @bookingDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get bookingDeletingError;

  /// No description provided for @bookingDeletingRoom.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la salle ?'**
  String get bookingDeletingRoom;

  /// No description provided for @bookingEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get bookingEdit;

  /// No description provided for @bookingEditBooking.
  ///
  /// In fr, this message translates to:
  /// **'Modifier une réservation'**
  String get bookingEditBooking;

  /// No description provided for @bookingEditionError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get bookingEditionError;

  /// No description provided for @bookingEditedBooking.
  ///
  /// In fr, this message translates to:
  /// **'Réservation modifiée'**
  String get bookingEditedBooking;

  /// No description provided for @bookingEditedRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle modifiée'**
  String get bookingEditedRoom;

  /// No description provided for @bookingEditedManager.
  ///
  /// In fr, this message translates to:
  /// **'Gestionnaire modifié'**
  String get bookingEditedManager;

  /// No description provided for @bookingEditManager.
  ///
  /// In fr, this message translates to:
  /// **'Modifier ou supprimer un gestionnaire'**
  String get bookingEditManager;

  /// No description provided for @bookingEditRoom.
  ///
  /// In fr, this message translates to:
  /// **'Modifier ou supprimer une salle'**
  String get bookingEditRoom;

  /// No description provided for @bookingEndDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin'**
  String get bookingEndDate;

  /// No description provided for @bookingEndHour.
  ///
  /// In fr, this message translates to:
  /// **'Heure de fin'**
  String get bookingEndHour;

  /// No description provided for @bookingEntity.
  ///
  /// In fr, this message translates to:
  /// **'Pour qui ?'**
  String get bookingEntity;

  /// No description provided for @bookingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get bookingError;

  /// No description provided for @bookingEventEvery.
  ///
  /// In fr, this message translates to:
  /// **'Tous les'**
  String get bookingEventEvery;

  /// No description provided for @bookingHistoryPage.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get bookingHistoryPage;

  /// No description provided for @bookingIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Champs incorrects ou manquants'**
  String get bookingIncorrectOrMissingFields;

  /// No description provided for @bookingInterval.
  ///
  /// In fr, this message translates to:
  /// **'Intervalle'**
  String get bookingInterval;

  /// No description provided for @bookingInvalidIntervalError.
  ///
  /// In fr, this message translates to:
  /// **'Intervalle invalide'**
  String get bookingInvalidIntervalError;

  /// No description provided for @bookingInvalidDates.
  ///
  /// In fr, this message translates to:
  /// **'Dates invalides'**
  String get bookingInvalidDates;

  /// No description provided for @bookingInvalidRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle invalide'**
  String get bookingInvalidRoom;

  /// No description provided for @bookingKeysRequested.
  ///
  /// In fr, this message translates to:
  /// **'Clés demandées'**
  String get bookingKeysRequested;

  /// No description provided for @bookingManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion'**
  String get bookingManagement;

  /// No description provided for @bookingManager.
  ///
  /// In fr, this message translates to:
  /// **'Gestionnaire'**
  String get bookingManager;

  /// No description provided for @bookingManagerName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du gestionnaire'**
  String get bookingManagerName;

  /// No description provided for @bookingMultipleDay.
  ///
  /// In fr, this message translates to:
  /// **'Plusieurs jours'**
  String get bookingMultipleDay;

  /// No description provided for @bookingMyBookings.
  ///
  /// In fr, this message translates to:
  /// **'Mes réservations'**
  String get bookingMyBookings;

  /// No description provided for @bookingNecessaryKey.
  ///
  /// In fr, this message translates to:
  /// **'Clé nécessaire'**
  String get bookingNecessaryKey;

  /// No description provided for @bookingNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get bookingNext;

  /// No description provided for @bookingNo.
  ///
  /// In fr, this message translates to:
  /// **'Non'**
  String get bookingNo;

  /// No description provided for @bookingNoCurrentBooking.
  ///
  /// In fr, this message translates to:
  /// **'Pas de réservation en cours'**
  String get bookingNoCurrentBooking;

  /// No description provided for @bookingNoDateError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir une date'**
  String get bookingNoDateError;

  /// No description provided for @bookingNoAppointmentInReccurence.
  ///
  /// In fr, this message translates to:
  /// **'Aucun créneau existe avec ces paramètres de récurrence'**
  String get bookingNoAppointmentInReccurence;

  /// No description provided for @bookingNoDaySelected.
  ///
  /// In fr, this message translates to:
  /// **'Aucun jour sélectionné'**
  String get bookingNoDaySelected;

  /// No description provided for @bookingNoDescriptionError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une description'**
  String get bookingNoDescriptionError;

  /// No description provided for @bookingNoKeys.
  ///
  /// In fr, this message translates to:
  /// **'Aucune clé'**
  String get bookingNoKeys;

  /// No description provided for @bookingNoNoteError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une note'**
  String get bookingNoNoteError;

  /// No description provided for @bookingNoPhoneRegistered.
  ///
  /// In fr, this message translates to:
  /// **'Numéro non renseigné'**
  String get bookingNoPhoneRegistered;

  /// No description provided for @bookingNoReasonError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un motif'**
  String get bookingNoReasonError;

  /// No description provided for @bookingNoRoomFoundError.
  ///
  /// In fr, this message translates to:
  /// **'Aucune salle enregistrée'**
  String get bookingNoRoomFoundError;

  /// No description provided for @bookingNoRoomFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucune salle trouvée'**
  String get bookingNoRoomFound;

  /// No description provided for @bookingNote.
  ///
  /// In fr, this message translates to:
  /// **'Note'**
  String get bookingNote;

  /// No description provided for @bookingOther.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get bookingOther;

  /// No description provided for @bookingPending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get bookingPending;

  /// No description provided for @bookingPrevious.
  ///
  /// In fr, this message translates to:
  /// **'Précédent'**
  String get bookingPrevious;

  /// No description provided for @bookingReason.
  ///
  /// In fr, this message translates to:
  /// **'Motif'**
  String get bookingReason;

  /// No description provided for @bookingRecurrence.
  ///
  /// In fr, this message translates to:
  /// **'Récurrence'**
  String get bookingRecurrence;

  /// No description provided for @bookingRecurrenceDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours de récurrence'**
  String get bookingRecurrenceDays;

  /// No description provided for @bookingRecurrenceEndDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin de récurrence'**
  String get bookingRecurrenceEndDate;

  /// No description provided for @bookingRecurrent.
  ///
  /// In fr, this message translates to:
  /// **'Récurrent'**
  String get bookingRecurrent;

  /// No description provided for @bookingRegisteredRooms.
  ///
  /// In fr, this message translates to:
  /// **'Salles enregistrées'**
  String get bookingRegisteredRooms;

  /// No description provided for @bookingRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle'**
  String get bookingRoom;

  /// No description provided for @bookingRoomName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la salle'**
  String get bookingRoomName;

  /// No description provided for @bookingStartDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get bookingStartDate;

  /// No description provided for @bookingStartHour.
  ///
  /// In fr, this message translates to:
  /// **'Heure de début'**
  String get bookingStartHour;

  /// No description provided for @bookingWeeks.
  ///
  /// In fr, this message translates to:
  /// **'Semaines'**
  String get bookingWeeks;

  /// No description provided for @bookingYes.
  ///
  /// In fr, this message translates to:
  /// **'Oui'**
  String get bookingYes;

  /// No description provided for @bookingWeekDayMon.
  ///
  /// In fr, this message translates to:
  /// **'Lundi'**
  String get bookingWeekDayMon;

  /// No description provided for @bookingWeekDayTue.
  ///
  /// In fr, this message translates to:
  /// **'Mardi'**
  String get bookingWeekDayTue;

  /// No description provided for @bookingWeekDayWed.
  ///
  /// In fr, this message translates to:
  /// **'Mercredi'**
  String get bookingWeekDayWed;

  /// No description provided for @bookingWeekDayThu.
  ///
  /// In fr, this message translates to:
  /// **'Jeudi'**
  String get bookingWeekDayThu;

  /// No description provided for @bookingWeekDayFri.
  ///
  /// In fr, this message translates to:
  /// **'Vendredi'**
  String get bookingWeekDayFri;

  /// No description provided for @bookingWeekDaySat.
  ///
  /// In fr, this message translates to:
  /// **'Samedi'**
  String get bookingWeekDaySat;

  /// No description provided for @bookingWeekDaySun.
  ///
  /// In fr, this message translates to:
  /// **'Dimanche'**
  String get bookingWeekDaySun;

  /// No description provided for @cinemaAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get cinemaAdd;

  /// No description provided for @cinemaAddedSession.
  ///
  /// In fr, this message translates to:
  /// **'Séance ajoutée'**
  String get cinemaAddedSession;

  /// No description provided for @cinemaAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get cinemaAddingError;

  /// No description provided for @cinemaAddSession.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une séance'**
  String get cinemaAddSession;

  /// No description provided for @cinemaCinema.
  ///
  /// In fr, this message translates to:
  /// **'Cinéma'**
  String get cinemaCinema;

  /// No description provided for @cinemaDeleteSession.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la séance ?'**
  String get cinemaDeleteSession;

  /// No description provided for @cinemaDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get cinemaDeleting;

  /// No description provided for @cinemaDuration.
  ///
  /// In fr, this message translates to:
  /// **'Durée'**
  String get cinemaDuration;

  /// No description provided for @cinemaEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get cinemaEdit;

  /// No description provided for @cinemaEditedSession.
  ///
  /// In fr, this message translates to:
  /// **'Séance modifiée'**
  String get cinemaEditedSession;

  /// No description provided for @cinemaEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get cinemaEditingError;

  /// No description provided for @cinemaEditSession.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la séance'**
  String get cinemaEditSession;

  /// No description provided for @cinemaEmptyUrl.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une URL'**
  String get cinemaEmptyUrl;

  /// No description provided for @cinemaImportFromTMDB.
  ///
  /// In fr, this message translates to:
  /// **'Importer depuis TMDB'**
  String get cinemaImportFromTMDB;

  /// No description provided for @cinemaIncomingSession.
  ///
  /// In fr, this message translates to:
  /// **'A l\'affiche'**
  String get cinemaIncomingSession;

  /// No description provided for @cinemaIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Champs incorrects ou manquants'**
  String get cinemaIncorrectOrMissingFields;

  /// No description provided for @cinemaInvalidUrl.
  ///
  /// In fr, this message translates to:
  /// **'URL invalide'**
  String get cinemaInvalidUrl;

  /// No description provided for @cinemaGenre.
  ///
  /// In fr, this message translates to:
  /// **'Genre'**
  String get cinemaGenre;

  /// No description provided for @cinemaName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get cinemaName;

  /// No description provided for @cinemaNoDateError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une date'**
  String get cinemaNoDateError;

  /// No description provided for @cinemaNoDuration.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une durée'**
  String get cinemaNoDuration;

  /// No description provided for @cinemaNoOverview.
  ///
  /// In fr, this message translates to:
  /// **'Aucun synopsis'**
  String get cinemaNoOverview;

  /// No description provided for @cinemaNoPoster.
  ///
  /// In fr, this message translates to:
  /// **'Aucune affiche'**
  String get cinemaNoPoster;

  /// No description provided for @cinemaNoSession.
  ///
  /// In fr, this message translates to:
  /// **'Aucune séance'**
  String get cinemaNoSession;

  /// No description provided for @cinemaOverview.
  ///
  /// In fr, this message translates to:
  /// **'Synopsis'**
  String get cinemaOverview;

  /// No description provided for @cinemaPosterUrl.
  ///
  /// In fr, this message translates to:
  /// **'URL de l\'affiche'**
  String get cinemaPosterUrl;

  /// No description provided for @cinemaSessionDate.
  ///
  /// In fr, this message translates to:
  /// **'Jour de la séance'**
  String get cinemaSessionDate;

  /// No description provided for @cinemaStartHour.
  ///
  /// In fr, this message translates to:
  /// **'Heure de début'**
  String get cinemaStartHour;

  /// No description provided for @cinemaTagline.
  ///
  /// In fr, this message translates to:
  /// **'Slogan'**
  String get cinemaTagline;

  /// No description provided for @cinemaThe.
  ///
  /// In fr, this message translates to:
  /// **'Le'**
  String get cinemaThe;

  /// No description provided for @drawerAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administration'**
  String get drawerAdmin;

  /// No description provided for @drawerAndroidAppLink.
  ///
  /// In fr, this message translates to:
  /// **'https://play.google.com/store/apps/details?id=fr.myecl.titan'**
  String get drawerAndroidAppLink;

  /// No description provided for @drawerCopied.
  ///
  /// In fr, this message translates to:
  /// **'Copié !'**
  String get drawerCopied;

  /// No description provided for @drawerDownloadAppOnMobileDevice.
  ///
  /// In fr, this message translates to:
  /// **'Ce site est la version Web de l\'application MyECL. Nous vous invitons à télécharger l\'application. N\'utilisez ce site qu\'en cas de problème avec l\'application.\n'**
  String get drawerDownloadAppOnMobileDevice;

  /// No description provided for @drawerIosAppLink.
  ///
  /// In fr, this message translates to:
  /// **'https://apps.apple.com/fr/app/myecl/id6444443430'**
  String get drawerIosAppLink;

  /// No description provided for @drawerLoginOut.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vous déconnecter ?'**
  String get drawerLoginOut;

  /// No description provided for @drawerLogOut.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion'**
  String get drawerLogOut;

  /// No description provided for @drawerOr.
  ///
  /// In fr, this message translates to:
  /// **' ou '**
  String get drawerOr;

  /// No description provided for @drawerSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get drawerSettings;

  /// No description provided for @eventAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get eventAdd;

  /// No description provided for @eventAddEvent.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un événement'**
  String get eventAddEvent;

  /// No description provided for @eventAddedEvent.
  ///
  /// In fr, this message translates to:
  /// **'Événement ajouté'**
  String get eventAddedEvent;

  /// No description provided for @eventAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get eventAddingError;

  /// No description provided for @eventAllDay.
  ///
  /// In fr, this message translates to:
  /// **'Toute la journée'**
  String get eventAllDay;

  /// No description provided for @eventConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get eventConfirm;

  /// No description provided for @eventConfirmEvent.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer l\'événement ?'**
  String get eventConfirmEvent;

  /// No description provided for @eventConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation'**
  String get eventConfirmation;

  /// No description provided for @eventConfirmed.
  ///
  /// In fr, this message translates to:
  /// **'Confirmé'**
  String get eventConfirmed;

  /// No description provided for @eventDates.
  ///
  /// In fr, this message translates to:
  /// **'Dates'**
  String get eventDates;

  /// No description provided for @eventDecline.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get eventDecline;

  /// No description provided for @eventDeclineEvent.
  ///
  /// In fr, this message translates to:
  /// **'Refuser l\'événement ?'**
  String get eventDeclineEvent;

  /// No description provided for @eventDeclined.
  ///
  /// In fr, this message translates to:
  /// **'Refusé'**
  String get eventDeclined;

  /// No description provided for @eventDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get eventDelete;

  /// No description provided for @eventDeletedEvent.
  ///
  /// In fr, this message translates to:
  /// **'Événement supprimé'**
  String get eventDeletedEvent;

  /// No description provided for @eventDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get eventDeleting;

  /// No description provided for @eventDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get eventDeletingError;

  /// No description provided for @eventDeletingEvent.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'événement ?'**
  String get eventDeletingEvent;

  /// No description provided for @eventDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get eventDescription;

  /// No description provided for @eventEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get eventEdit;

  /// No description provided for @eventEditEvent.
  ///
  /// In fr, this message translates to:
  /// **'Modifier un événement'**
  String get eventEditEvent;

  /// No description provided for @eventEditedEvent.
  ///
  /// In fr, this message translates to:
  /// **'Événement modifié'**
  String get eventEditedEvent;

  /// No description provided for @eventEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get eventEditingError;

  /// No description provided for @eventEndDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin'**
  String get eventEndDate;

  /// No description provided for @eventEndHour.
  ///
  /// In fr, this message translates to:
  /// **'Heure de fin'**
  String get eventEndHour;

  /// No description provided for @eventError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get eventError;

  /// No description provided for @eventEventList.
  ///
  /// In fr, this message translates to:
  /// **'Liste des événements'**
  String get eventEventList;

  /// No description provided for @eventEventType.
  ///
  /// In fr, this message translates to:
  /// **'Type d\'événement'**
  String get eventEventType;

  /// No description provided for @eventEvery.
  ///
  /// In fr, this message translates to:
  /// **'Tous les'**
  String get eventEvery;

  /// No description provided for @eventHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get eventHistory;

  /// No description provided for @eventIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Certains champs sont incorrects ou manquants'**
  String get eventIncorrectOrMissingFields;

  /// No description provided for @eventInterval.
  ///
  /// In fr, this message translates to:
  /// **'Intervalle'**
  String get eventInterval;

  /// No description provided for @eventInvalidDates.
  ///
  /// In fr, this message translates to:
  /// **'La date de fin doit être après la date de début'**
  String get eventInvalidDates;

  /// No description provided for @eventInvalidIntervalError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un intervalle valide'**
  String get eventInvalidIntervalError;

  /// No description provided for @eventLocation.
  ///
  /// In fr, this message translates to:
  /// **'Lieu'**
  String get eventLocation;

  /// No description provided for @eventMyEvents.
  ///
  /// In fr, this message translates to:
  /// **'Mes événements'**
  String get eventMyEvents;

  /// No description provided for @eventName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get eventName;

  /// No description provided for @eventNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get eventNext;

  /// No description provided for @eventNo.
  ///
  /// In fr, this message translates to:
  /// **'Non'**
  String get eventNo;

  /// No description provided for @eventNoCurrentEvent.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement en cours'**
  String get eventNoCurrentEvent;

  /// No description provided for @eventNoDateError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une date'**
  String get eventNoDateError;

  /// No description provided for @eventNoDaySelected.
  ///
  /// In fr, this message translates to:
  /// **'Aucun jour sélectionné'**
  String get eventNoDaySelected;

  /// No description provided for @eventNoDescriptionError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une description'**
  String get eventNoDescriptionError;

  /// No description provided for @eventNoEvent.
  ///
  /// In fr, this message translates to:
  /// **'Aucun événement'**
  String get eventNoEvent;

  /// No description provided for @eventNoNameError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nom'**
  String get eventNoNameError;

  /// No description provided for @eventNoOrganizerError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un organisateur'**
  String get eventNoOrganizerError;

  /// No description provided for @eventNoPlaceError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un lieu'**
  String get eventNoPlaceError;

  /// No description provided for @eventNoPhoneRegistered.
  ///
  /// In fr, this message translates to:
  /// **'Numéro non renseigné'**
  String get eventNoPhoneRegistered;

  /// No description provided for @eventNoRuleError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une règle de récurrence'**
  String get eventNoRuleError;

  /// No description provided for @eventOrganizer.
  ///
  /// In fr, this message translates to:
  /// **'Organisateur'**
  String get eventOrganizer;

  /// No description provided for @eventOther.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get eventOther;

  /// No description provided for @eventPending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get eventPending;

  /// No description provided for @eventPrevious.
  ///
  /// In fr, this message translates to:
  /// **'Précédent'**
  String get eventPrevious;

  /// No description provided for @eventRecurrence.
  ///
  /// In fr, this message translates to:
  /// **'Récurrence'**
  String get eventRecurrence;

  /// No description provided for @eventRecurrenceDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours de récurrence'**
  String get eventRecurrenceDays;

  /// No description provided for @eventRecurrenceEndDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin de la récurrence'**
  String get eventRecurrenceEndDate;

  /// No description provided for @eventRecurrenceRule.
  ///
  /// In fr, this message translates to:
  /// **'Règle de récurrence'**
  String get eventRecurrenceRule;

  /// No description provided for @eventRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle'**
  String get eventRoom;

  /// No description provided for @eventStartDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get eventStartDate;

  /// No description provided for @eventStartHour.
  ///
  /// In fr, this message translates to:
  /// **'Heure de début'**
  String get eventStartHour;

  /// No description provided for @eventTitle.
  ///
  /// In fr, this message translates to:
  /// **'Événements'**
  String get eventTitle;

  /// No description provided for @eventYes.
  ///
  /// In fr, this message translates to:
  /// **'Oui'**
  String get eventYes;

  /// No description provided for @eventEventEvery.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les'**
  String get eventEventEvery;

  /// No description provided for @eventWeeks.
  ///
  /// In fr, this message translates to:
  /// **'semaines'**
  String get eventWeeks;

  /// No description provided for @eventDayMon.
  ///
  /// In fr, this message translates to:
  /// **'Lundi'**
  String get eventDayMon;

  /// No description provided for @eventDayTue.
  ///
  /// In fr, this message translates to:
  /// **'Mardi'**
  String get eventDayTue;

  /// No description provided for @eventDayWed.
  ///
  /// In fr, this message translates to:
  /// **'Mercredi'**
  String get eventDayWed;

  /// No description provided for @eventDayThu.
  ///
  /// In fr, this message translates to:
  /// **'Jeudi'**
  String get eventDayThu;

  /// No description provided for @eventDayFri.
  ///
  /// In fr, this message translates to:
  /// **'Vendredi'**
  String get eventDayFri;

  /// No description provided for @eventDaySat.
  ///
  /// In fr, this message translates to:
  /// **'Samedi'**
  String get eventDaySat;

  /// No description provided for @eventDaySun.
  ///
  /// In fr, this message translates to:
  /// **'Dimanche'**
  String get eventDaySun;

  /// No description provided for @globalConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get globalConfirm;

  /// No description provided for @globalCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get globalCancel;

  /// No description provided for @globalIrreversibleAction.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible'**
  String get globalIrreversibleAction;

  /// Texte avec complément optionnel
  ///
  /// In fr, this message translates to:
  /// **'{text} (Optionnel)'**
  String globalOptionnal(String text);

  /// No description provided for @homeCalendar.
  ///
  /// In fr, this message translates to:
  /// **'Calendrier'**
  String get homeCalendar;

  /// No description provided for @homeEventOf.
  ///
  /// In fr, this message translates to:
  /// **'Évènements du'**
  String get homeEventOf;

  /// No description provided for @homeIncomingEvents.
  ///
  /// In fr, this message translates to:
  /// **'Évènements à venir'**
  String get homeIncomingEvents;

  /// No description provided for @homeLastInfos.
  ///
  /// In fr, this message translates to:
  /// **'Dernières annonces'**
  String get homeLastInfos;

  /// No description provided for @homeNoEvents.
  ///
  /// In fr, this message translates to:
  /// **'Aucun évènement'**
  String get homeNoEvents;

  /// No description provided for @homeTranslateDayShortMon.
  ///
  /// In fr, this message translates to:
  /// **'Lun'**
  String get homeTranslateDayShortMon;

  /// No description provided for @homeTranslateDayShortTue.
  ///
  /// In fr, this message translates to:
  /// **'Mar'**
  String get homeTranslateDayShortTue;

  /// No description provided for @homeTranslateDayShortWed.
  ///
  /// In fr, this message translates to:
  /// **'Mer'**
  String get homeTranslateDayShortWed;

  /// No description provided for @homeTranslateDayShortThu.
  ///
  /// In fr, this message translates to:
  /// **'Jeu'**
  String get homeTranslateDayShortThu;

  /// No description provided for @homeTranslateDayShortFri.
  ///
  /// In fr, this message translates to:
  /// **'Ven'**
  String get homeTranslateDayShortFri;

  /// No description provided for @homeTranslateDayShortSat.
  ///
  /// In fr, this message translates to:
  /// **'Sam'**
  String get homeTranslateDayShortSat;

  /// No description provided for @homeTranslateDayShortSun.
  ///
  /// In fr, this message translates to:
  /// **'Dim'**
  String get homeTranslateDayShortSun;

  /// No description provided for @loanAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get loanAdd;

  /// No description provided for @loanAddLoan.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un prêt'**
  String get loanAddLoan;

  /// No description provided for @loanAddObject.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un objet'**
  String get loanAddObject;

  /// No description provided for @loanAddedLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt ajouté'**
  String get loanAddedLoan;

  /// No description provided for @loanAddedObject.
  ///
  /// In fr, this message translates to:
  /// **'Objet ajouté'**
  String get loanAddedObject;

  /// No description provided for @loanAddedRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle ajoutée'**
  String get loanAddedRoom;

  /// No description provided for @loanAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get loanAddingError;

  /// No description provided for @loanAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur'**
  String get loanAdmin;

  /// No description provided for @loanAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Disponible'**
  String get loanAvailable;

  /// No description provided for @loanAvailableMultiple.
  ///
  /// In fr, this message translates to:
  /// **'Disponibles'**
  String get loanAvailableMultiple;

  /// No description provided for @loanBorrowed.
  ///
  /// In fr, this message translates to:
  /// **'Emprunté'**
  String get loanBorrowed;

  /// No description provided for @loanBorrowedMultiple.
  ///
  /// In fr, this message translates to:
  /// **'Empruntés'**
  String get loanBorrowedMultiple;

  /// No description provided for @loanAnd.
  ///
  /// In fr, this message translates to:
  /// **'et'**
  String get loanAnd;

  /// No description provided for @loanAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association'**
  String get loanAssociation;

  /// No description provided for @loanAvailableItems.
  ///
  /// In fr, this message translates to:
  /// **'Objets disponibles'**
  String get loanAvailableItems;

  /// No description provided for @loanBeginDate.
  ///
  /// In fr, this message translates to:
  /// **'Date du début du prêt'**
  String get loanBeginDate;

  /// No description provided for @loanBorrower.
  ///
  /// In fr, this message translates to:
  /// **'Emprunteur'**
  String get loanBorrower;

  /// No description provided for @loanCaution.
  ///
  /// In fr, this message translates to:
  /// **'Caution'**
  String get loanCaution;

  /// No description provided for @loanCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get loanCancel;

  /// No description provided for @loanConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get loanConfirm;

  /// No description provided for @loanConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation'**
  String get loanConfirmation;

  /// No description provided for @loanDates.
  ///
  /// In fr, this message translates to:
  /// **'Dates'**
  String get loanDates;

  /// No description provided for @loanDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours'**
  String get loanDays;

  /// No description provided for @loanDelay.
  ///
  /// In fr, this message translates to:
  /// **'Délai de la prolongation'**
  String get loanDelay;

  /// No description provided for @loanDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get loanDelete;

  /// No description provided for @loanDeletingLoan.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le prêt ?'**
  String get loanDeletingLoan;

  /// No description provided for @loanDeletedItem.
  ///
  /// In fr, this message translates to:
  /// **'Objet supprimé'**
  String get loanDeletedItem;

  /// No description provided for @loanDeletedLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt supprimé'**
  String get loanDeletedLoan;

  /// No description provided for @loanDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get loanDeleting;

  /// No description provided for @loanDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get loanDeletingError;

  /// No description provided for @loanDeletingItem.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'objet ?'**
  String get loanDeletingItem;

  /// No description provided for @loanDuration.
  ///
  /// In fr, this message translates to:
  /// **'Durée'**
  String get loanDuration;

  /// No description provided for @loanEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get loanEdit;

  /// No description provided for @loanEditItem.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'objet'**
  String get loanEditItem;

  /// No description provided for @loanEditLoan.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le prêt'**
  String get loanEditLoan;

  /// No description provided for @loanEditedRoom.
  ///
  /// In fr, this message translates to:
  /// **'Salle modifiée'**
  String get loanEditedRoom;

  /// No description provided for @loanEndDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin du prêt'**
  String get loanEndDate;

  /// No description provided for @loanEnded.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get loanEnded;

  /// No description provided for @loanEnterDate.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une date'**
  String get loanEnterDate;

  /// No description provided for @loanExtendedLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt prolongé'**
  String get loanExtendedLoan;

  /// No description provided for @loanExtendingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la prolongation'**
  String get loanExtendingError;

  /// No description provided for @loanHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get loanHistory;

  /// No description provided for @loanIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Des champs sont manquants ou incorrects'**
  String get loanIncorrectOrMissingFields;

  /// No description provided for @loanInvalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre'**
  String get loanInvalidNumber;

  /// No description provided for @loanInvalidDates.
  ///
  /// In fr, this message translates to:
  /// **'Les dates ne sont pas valides'**
  String get loanInvalidDates;

  /// No description provided for @loanItem.
  ///
  /// In fr, this message translates to:
  /// **'Objet'**
  String get loanItem;

  /// No description provided for @loanItems.
  ///
  /// In fr, this message translates to:
  /// **'Objets'**
  String get loanItems;

  /// No description provided for @loanItemHandling.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des objets'**
  String get loanItemHandling;

  /// No description provided for @loanItemSelected.
  ///
  /// In fr, this message translates to:
  /// **'objet sélectionné'**
  String get loanItemSelected;

  /// No description provided for @loanItemsSelected.
  ///
  /// In fr, this message translates to:
  /// **'objets sélectionnés'**
  String get loanItemsSelected;

  /// No description provided for @loanLendingDuration.
  ///
  /// In fr, this message translates to:
  /// **'Durée possible du prêt'**
  String get loanLendingDuration;

  /// No description provided for @loanLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt'**
  String get loanLoan;

  /// No description provided for @loanLoanHandling.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des prêts'**
  String get loanLoanHandling;

  /// No description provided for @loanLooking.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get loanLooking;

  /// No description provided for @loanName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get loanName;

  /// No description provided for @loanNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get loanNext;

  /// No description provided for @loanNo.
  ///
  /// In fr, this message translates to:
  /// **'Non'**
  String get loanNo;

  /// No description provided for @loanNoAssociationsFounded.
  ///
  /// In fr, this message translates to:
  /// **'Aucune association trouvée'**
  String get loanNoAssociationsFounded;

  /// No description provided for @loanNoAvailableItems.
  ///
  /// In fr, this message translates to:
  /// **'Aucun objet disponible'**
  String get loanNoAvailableItems;

  /// No description provided for @loanNoBorrower.
  ///
  /// In fr, this message translates to:
  /// **'Aucun emprunteur'**
  String get loanNoBorrower;

  /// No description provided for @loanNoItems.
  ///
  /// In fr, this message translates to:
  /// **'Aucun objet'**
  String get loanNoItems;

  /// No description provided for @loanNoItemSelected.
  ///
  /// In fr, this message translates to:
  /// **'Aucun objet sélectionné'**
  String get loanNoItemSelected;

  /// No description provided for @loanNoLoan.
  ///
  /// In fr, this message translates to:
  /// **'Aucun prêt'**
  String get loanNoLoan;

  /// No description provided for @loanNoReturnedDate.
  ///
  /// In fr, this message translates to:
  /// **'Pas de date de retour'**
  String get loanNoReturnedDate;

  /// No description provided for @loanQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get loanQuantity;

  /// No description provided for @loanNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get loanNone;

  /// No description provided for @loanNote.
  ///
  /// In fr, this message translates to:
  /// **'Note'**
  String get loanNote;

  /// No description provided for @loanNoValue.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une valeur'**
  String get loanNoValue;

  /// No description provided for @loanOnGoing.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get loanOnGoing;

  /// No description provided for @loanOnGoingLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt en cours'**
  String get loanOnGoingLoan;

  /// No description provided for @loanOthers.
  ///
  /// In fr, this message translates to:
  /// **'autres'**
  String get loanOthers;

  /// No description provided for @loanPaidCaution.
  ///
  /// In fr, this message translates to:
  /// **'Caution payée'**
  String get loanPaidCaution;

  /// No description provided for @loanPositiveNumber.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre positif'**
  String get loanPositiveNumber;

  /// No description provided for @loanPrevious.
  ///
  /// In fr, this message translates to:
  /// **'Précédent'**
  String get loanPrevious;

  /// No description provided for @loanReturned.
  ///
  /// In fr, this message translates to:
  /// **'Rendu'**
  String get loanReturned;

  /// No description provided for @loanReturnedLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt rendu'**
  String get loanReturnedLoan;

  /// No description provided for @loanReturningError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du retour'**
  String get loanReturningError;

  /// No description provided for @loanReturningLoan.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get loanReturningLoan;

  /// No description provided for @loanReturnLoan.
  ///
  /// In fr, this message translates to:
  /// **'Rendre le prêt ?'**
  String get loanReturnLoan;

  /// No description provided for @loanReturnLoanDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous rendre ce prêt ?'**
  String get loanReturnLoanDescription;

  /// No description provided for @loanToReturn.
  ///
  /// In fr, this message translates to:
  /// **'A rendre'**
  String get loanToReturn;

  /// No description provided for @loanUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Indisponible'**
  String get loanUnavailable;

  /// No description provided for @loanUpdate.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get loanUpdate;

  /// No description provided for @loanUpdatedItem.
  ///
  /// In fr, this message translates to:
  /// **'Objet modifié'**
  String get loanUpdatedItem;

  /// No description provided for @loanUpdatedLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt modifié'**
  String get loanUpdatedLoan;

  /// No description provided for @loanUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get loanUpdatingError;

  /// No description provided for @loanYes.
  ///
  /// In fr, this message translates to:
  /// **'Oui'**
  String get loanYes;

  /// No description provided for @loginAppName.
  ///
  /// In fr, this message translates to:
  /// **'MyECL'**
  String get loginAppName;

  /// No description provided for @loginCreateAccount.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get loginCreateAccount;

  /// No description provided for @loginForgotPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get loginForgotPassword;

  /// No description provided for @loginFruitVegetableOrders.
  ///
  /// In fr, this message translates to:
  /// **'Commandes de fruits et légumes'**
  String get loginFruitVegetableOrders;

  /// No description provided for @loginInterfaceCustomization.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisation de l\'interface'**
  String get loginInterfaceCustomization;

  /// No description provided for @loginLoginFailed.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la connexion'**
  String get loginLoginFailed;

  /// No description provided for @loginMadeBy.
  ///
  /// In fr, this message translates to:
  /// **'Développé par ProximApp'**
  String get loginMadeBy;

  /// No description provided for @loginMaterialLoans.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des prêts de matériel'**
  String get loginMaterialLoans;

  /// No description provided for @loginNewTermsElections.
  ///
  /// In fr, this message translates to:
  /// **'L\'élection des nouveaux mandats'**
  String get loginNewTermsElections;

  /// No description provided for @loginRaffles.
  ///
  /// In fr, this message translates to:
  /// **'Tombolas'**
  String get loginRaffles;

  /// No description provided for @loginSignIn.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get loginSignIn;

  /// No description provided for @loginRegister.
  ///
  /// In fr, this message translates to:
  /// **'S\'inscrire'**
  String get loginRegister;

  /// No description provided for @loginShortDescription.
  ///
  /// In fr, this message translates to:
  /// **'L\'application de l\'associatif'**
  String get loginShortDescription;

  /// No description provided for @loginUpcomingEvents.
  ///
  /// In fr, this message translates to:
  /// **'Les évènements à venir'**
  String get loginUpcomingEvents;

  /// No description provided for @loginUpcomingScreenings.
  ///
  /// In fr, this message translates to:
  /// **'Les prochaines séances'**
  String get loginUpcomingScreenings;

  /// No description provided for @othersCheckInternetConnection.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez vérifier votre connexion internet'**
  String get othersCheckInternetConnection;

  /// No description provided for @othersRetry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get othersRetry;

  /// No description provided for @othersTooOldVersion.
  ///
  /// In fr, this message translates to:
  /// **'Votre version de l\'application est trop ancienne.\n\nVeuillez mettre à jour l\'application.'**
  String get othersTooOldVersion;

  /// No description provided for @othersUnableToConnectToServer.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de se connecter au serveur'**
  String get othersUnableToConnectToServer;

  /// No description provided for @othersVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get othersVersion;

  /// No description provided for @othersNoModule.
  ///
  /// In fr, this message translates to:
  /// **'Aucun module disponible, veuillez réessayer ultérieurement 😢😢'**
  String get othersNoModule;

  /// No description provided for @othersAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Admin'**
  String get othersAdmin;

  /// No description provided for @othersError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue'**
  String get othersError;

  /// No description provided for @othersNoValue.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une valeur'**
  String get othersNoValue;

  /// No description provided for @othersInvalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre'**
  String get othersInvalidNumber;

  /// No description provided for @othersNoDateError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une date'**
  String get othersNoDateError;

  /// No description provided for @othersImageSizeTooBig.
  ///
  /// In fr, this message translates to:
  /// **'La taille de l\'image ne doit pas dépasser 4 Mio'**
  String get othersImageSizeTooBig;

  /// No description provided for @othersImageError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout de l\'image'**
  String get othersImageError;

  /// No description provided for @paiementAccept.
  ///
  /// In fr, this message translates to:
  /// **'Accepter'**
  String get paiementAccept;

  /// No description provided for @paiementAccessPage.
  ///
  /// In fr, this message translates to:
  /// **'Accéder à la page'**
  String get paiementAccessPage;

  /// No description provided for @paiementAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get paiementAdd;

  /// No description provided for @paiementAddedSeller.
  ///
  /// In fr, this message translates to:
  /// **'Vendeur ajouté'**
  String get paiementAddedSeller;

  /// No description provided for @paiementAddingSellerError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout du vendeur'**
  String get paiementAddingSellerError;

  /// No description provided for @paiementAddingStoreError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout du magasin'**
  String get paiementAddingStoreError;

  /// No description provided for @paiementAddSeller.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un vendeur'**
  String get paiementAddSeller;

  /// No description provided for @paiementAddStore.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un magasin'**
  String get paiementAddStore;

  /// No description provided for @paiementAddThisDevice.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter cet appareil'**
  String get paiementAddThisDevice;

  /// No description provided for @paiementAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur'**
  String get paiementAdmin;

  /// No description provided for @paiementAmount.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get paiementAmount;

  /// No description provided for @paiementAskDeviceActivation.
  ///
  /// In fr, this message translates to:
  /// **'Demande d\'activation de l\'appareil'**
  String get paiementAskDeviceActivation;

  /// No description provided for @paiementAStore.
  ///
  /// In fr, this message translates to:
  /// **'un magasin'**
  String get paiementAStore;

  /// No description provided for @paiementAt.
  ///
  /// In fr, this message translates to:
  /// **'à'**
  String get paiementAt;

  /// No description provided for @paiementAuthenticationRequired.
  ///
  /// In fr, this message translates to:
  /// **'Authentification requise pour payer'**
  String get paiementAuthenticationRequired;

  /// No description provided for @paiementAuthentificationFailed.
  ///
  /// In fr, this message translates to:
  /// **'Échec de l\'authentification'**
  String get paiementAuthentificationFailed;

  /// No description provided for @paiementBalanceAfterTopUp.
  ///
  /// In fr, this message translates to:
  /// **'Solde après recharge :'**
  String get paiementBalanceAfterTopUp;

  /// No description provided for @paiementBalanceAfterTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Solde après paiement : '**
  String get paiementBalanceAfterTransaction;

  /// No description provided for @paiementBank.
  ///
  /// In fr, this message translates to:
  /// **'Encaisser'**
  String get paiementBank;

  /// No description provided for @paiementBillingSpace.
  ///
  /// In fr, this message translates to:
  /// **'Espace facturation'**
  String get paiementBillingSpace;

  /// No description provided for @paiementCameraPermissionRequired.
  ///
  /// In fr, this message translates to:
  /// **'Permission d\'accès à la caméra requise'**
  String get paiementCameraPermissionRequired;

  /// No description provided for @paiementCameraPerssionRequiredDescription.
  ///
  /// In fr, this message translates to:
  /// **'Pour scanner un QR Code, vous devez autoriser l\'accès à la caméra.'**
  String get paiementCameraPerssionRequiredDescription;

  /// No description provided for @paiementCanBank.
  ///
  /// In fr, this message translates to:
  /// **'Peut encaisser'**
  String get paiementCanBank;

  /// No description provided for @paiementCanCancelTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Peut annuler des transactions'**
  String get paiementCanCancelTransaction;

  /// No description provided for @paiementCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get paiementCancel;

  /// No description provided for @paiementCancelled.
  ///
  /// In fr, this message translates to:
  /// **'Annulé'**
  String get paiementCancelled;

  /// No description provided for @paiementCancelledTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Paiement annulé'**
  String get paiementCancelledTransaction;

  /// No description provided for @paiementCancelTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Annuler la transaction'**
  String get paiementCancelTransaction;

  /// No description provided for @paiementCancelTransactions.
  ///
  /// In fr, this message translates to:
  /// **'Annuler les transactions'**
  String get paiementCancelTransactions;

  /// No description provided for @paiementCanManageSellers.
  ///
  /// In fr, this message translates to:
  /// **'Peut gérer les vendeurs'**
  String get paiementCanManageSellers;

  /// No description provided for @paiementCanSeeHistory.
  ///
  /// In fr, this message translates to:
  /// **'Peut voir l\'historique'**
  String get paiementCanSeeHistory;

  /// No description provided for @paiementCantLaunchURL.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'ouvrir le lien'**
  String get paiementCantLaunchURL;

  /// No description provided for @paiementClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get paiementClose;

  /// No description provided for @paiementCreate.
  ///
  /// In fr, this message translates to:
  /// **'Créer'**
  String get paiementCreate;

  /// No description provided for @paiementCreateInvoice.
  ///
  /// In fr, this message translates to:
  /// **'Créer une facture'**
  String get paiementCreateInvoice;

  /// No description provided for @paiementDecline.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get paiementDecline;

  /// No description provided for @paiementDeletedSeller.
  ///
  /// In fr, this message translates to:
  /// **'Vendeur supprimé'**
  String get paiementDeletedSeller;

  /// No description provided for @paiementDeleteInvoice.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la facture'**
  String get paiementDeleteInvoice;

  /// No description provided for @paiementDeleteSeller.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le vendeur'**
  String get paiementDeleteSeller;

  /// No description provided for @paiementDeleteSellerDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer ce vendeur ?'**
  String get paiementDeleteSellerDescription;

  /// No description provided for @paiementDeleteSuccessfully.
  ///
  /// In fr, this message translates to:
  /// **'Supprimé avec succès'**
  String get paiementDeleteSuccessfully;

  /// No description provided for @paiementDeleteStore.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le magasin'**
  String get paiementDeleteStore;

  /// No description provided for @paiementDeleteStoreDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer ce magasin ?'**
  String get paiementDeleteStoreDescription;

  /// No description provided for @paiementDeleteStoreError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de supprimer le magasin'**
  String get paiementDeleteStoreError;

  /// No description provided for @paiementDeletingSellerError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression du vendeur'**
  String get paiementDeletingSellerError;

  /// No description provided for @paiementDeviceActivationReceived.
  ///
  /// In fr, this message translates to:
  /// **'La demande d\'activation est prise en compte, veuilliez consulter votre boite mail pour finaliser la démarche'**
  String get paiementDeviceActivationReceived;

  /// No description provided for @paiementDeviceNotActivated.
  ///
  /// In fr, this message translates to:
  /// **'Appareil non activé'**
  String get paiementDeviceNotActivated;

  /// No description provided for @paiementDeviceNotActivatedDescription.
  ///
  /// In fr, this message translates to:
  /// **'Votre appareil n\'est pas encore activé. \nPour l\'activer, veuillez vous rendre sur la page des appareils.'**
  String get paiementDeviceNotActivatedDescription;

  /// No description provided for @paiementDeviceNotRegistered.
  ///
  /// In fr, this message translates to:
  /// **'Appareil non enregistré'**
  String get paiementDeviceNotRegistered;

  /// No description provided for @paiementDeviceNotRegisteredDescription.
  ///
  /// In fr, this message translates to:
  /// **'Votre appareil n\'est pas encore enregistré. \nPour l\'enregistrer, veuillez vous rendre sur la page des appareils.'**
  String get paiementDeviceNotRegisteredDescription;

  /// No description provided for @paiementDeviceRecoveryError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la récupération de l\'appareil'**
  String get paiementDeviceRecoveryError;

  /// No description provided for @paiementDeviceRevoked.
  ///
  /// In fr, this message translates to:
  /// **'Appareil révoqué'**
  String get paiementDeviceRevoked;

  /// No description provided for @paiementDeviceRevokingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la révocation de l\'appareil'**
  String get paiementDeviceRevokingError;

  /// No description provided for @paiementDevices.
  ///
  /// In fr, this message translates to:
  /// **'Appareils'**
  String get paiementDevices;

  /// No description provided for @paiementDoneTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Transaction effectuée'**
  String get paiementDoneTransaction;

  /// No description provided for @paiementDownload.
  ///
  /// In fr, this message translates to:
  /// **'Télécharger'**
  String get paiementDownload;

  /// Modifier le magasin
  ///
  /// In fr, this message translates to:
  /// **'Modifier le magasin {store}'**
  String paiementEditStore(String store);

  /// No description provided for @paiementErrorDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get paiementErrorDeleting;

  /// No description provided for @paiementErrorUpdatingStatus.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la mise à jour du statut'**
  String get paiementErrorUpdatingStatus;

  /// Text with a date range
  ///
  /// In fr, this message translates to:
  /// **'Du {from} au {to}'**
  String paiementFromTo(DateTime from, DateTime to);

  /// No description provided for @paiementGetBalanceError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la récupération du solde : '**
  String get paiementGetBalanceError;

  /// No description provided for @paiementGetTransactionsError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la récupération des transactions : '**
  String get paiementGetTransactionsError;

  /// No description provided for @paiementHandOver.
  ///
  /// In fr, this message translates to:
  /// **'Passation'**
  String get paiementHandOver;

  /// No description provided for @paiementHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get paiementHistory;

  /// No description provided for @paiementInvoiceCreatedSuccessfully.
  ///
  /// In fr, this message translates to:
  /// **'Facture créée avec succès'**
  String get paiementInvoiceCreatedSuccessfully;

  /// No description provided for @paiementInvoices.
  ///
  /// In fr, this message translates to:
  /// **'Factures'**
  String get paiementInvoices;

  /// Text with the number of invoices per page
  ///
  /// In fr, this message translates to:
  /// **'{quantity} factures/page'**
  String paiementInvoicesPerPage(int quantity);

  /// No description provided for @paiementLastTransactions.
  ///
  /// In fr, this message translates to:
  /// **'Dernières transactions'**
  String get paiementLastTransactions;

  /// No description provided for @paiementLimitedTo.
  ///
  /// In fr, this message translates to:
  /// **'Limité à'**
  String get paiementLimitedTo;

  /// No description provided for @paiementManagement.
  ///
  /// In fr, this message translates to:
  /// **'Gestion'**
  String get paiementManagement;

  /// No description provided for @paiementManageSellers.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les vendeurs'**
  String get paiementManageSellers;

  /// No description provided for @paiementMarkPaid.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme payé'**
  String get paiementMarkPaid;

  /// No description provided for @paiementMarkReceived.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme reçu'**
  String get paiementMarkReceived;

  /// No description provided for @paiementMarkUnpaid.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme non payé'**
  String get paiementMarkUnpaid;

  /// No description provided for @paiementMaxAmount.
  ///
  /// In fr, this message translates to:
  /// **'Le montant maximum de votre portefeuille est de'**
  String get paiementMaxAmount;

  /// No description provided for @paiementMean.
  ///
  /// In fr, this message translates to:
  /// **'Moyenne : '**
  String get paiementMean;

  /// No description provided for @paiementModify.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get paiementModify;

  /// No description provided for @paiementModifyingStoreError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification du magasin'**
  String get paiementModifyingStoreError;

  /// No description provided for @paiementModifySuccessfully.
  ///
  /// In fr, this message translates to:
  /// **'Modifié avec succès'**
  String get paiementModifySuccessfully;

  /// No description provided for @paiementNewCGU.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelles Conditions Générales d\'Utilisation'**
  String get paiementNewCGU;

  /// No description provided for @paiementNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get paiementNext;

  /// No description provided for @paiementNextAccountable.
  ///
  /// In fr, this message translates to:
  /// **'Prochain responsable'**
  String get paiementNextAccountable;

  /// No description provided for @paiementNoInvoiceToCreate.
  ///
  /// In fr, this message translates to:
  /// **'Aucune facture à créer'**
  String get paiementNoInvoiceToCreate;

  /// No description provided for @paiementNoMembership.
  ///
  /// In fr, this message translates to:
  /// **'Aucune adhésion'**
  String get paiementNoMembership;

  /// No description provided for @paiementNoMembershipDescription.
  ///
  /// In fr, this message translates to:
  /// **'Ce produit n\'est pas disponnible pour les non-adhérents. Confirmer l\'encaissement ?'**
  String get paiementNoMembershipDescription;

  /// No description provided for @paiementNoThanks.
  ///
  /// In fr, this message translates to:
  /// **'Non merci'**
  String get paiementNoThanks;

  /// No description provided for @paiementNoTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Aucune transaction'**
  String get paiementNoTransaction;

  /// No description provided for @paiementNoTransactionForThisMonth.
  ///
  /// In fr, this message translates to:
  /// **'Aucune transaction pour ce mois'**
  String get paiementNoTransactionForThisMonth;

  /// No description provided for @paiementOf.
  ///
  /// In fr, this message translates to:
  /// **'de'**
  String get paiementOf;

  /// No description provided for @paiementPaid.
  ///
  /// In fr, this message translates to:
  /// **'Payé'**
  String get paiementPaid;

  /// No description provided for @paiementPay.
  ///
  /// In fr, this message translates to:
  /// **'Payer'**
  String get paiementPay;

  /// No description provided for @paiementPayment.
  ///
  /// In fr, this message translates to:
  /// **'Paiement'**
  String get paiementPayment;

  /// No description provided for @paiementPayWithHA.
  ///
  /// In fr, this message translates to:
  /// **'Payer avec HelloAsso'**
  String get paiementPayWithHA;

  /// No description provided for @paiementPending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get paiementPending;

  /// No description provided for @paiementPersonalBalance.
  ///
  /// In fr, this message translates to:
  /// **'Solde personnel'**
  String get paiementPersonalBalance;

  /// No description provided for @paiementPleaseAcceptPopup.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez autoriser les popups'**
  String get paiementPleaseAcceptPopup;

  /// No description provided for @paiementPleaseAcceptTOS.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez accepter les Conditions Générales d\'Utilisation.'**
  String get paiementPleaseAcceptTOS;

  /// No description provided for @paiementPleaseAddDevice.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez ajouter cet appareil pour payer'**
  String get paiementPleaseAddDevice;

  /// No description provided for @paiementPleaseAuthenticate.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez vous authentifier'**
  String get paiementPleaseAuthenticate;

  /// No description provided for @paiementPleaseEnterMinAmount.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un montant supérieur à 1'**
  String get paiementPleaseEnterMinAmount;

  /// No description provided for @paiementPleaseEnterValidAmount.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un montant valide'**
  String get paiementPleaseEnterValidAmount;

  /// No description provided for @paiementProceedSuccessfully.
  ///
  /// In fr, this message translates to:
  /// **'Paiement effectué avec succès'**
  String get paiementProceedSuccessfully;

  /// No description provided for @paiementQRCodeAlreadyUsed.
  ///
  /// In fr, this message translates to:
  /// **'QR Code déjà utilisé'**
  String get paiementQRCodeAlreadyUsed;

  /// No description provided for @paiementReactivateRevokedDeviceDescription.
  ///
  /// In fr, this message translates to:
  /// **'Votre appareil a été révoqué. \nPour le réactiver, veuillez vous rendre sur la page des appareils.'**
  String get paiementReactivateRevokedDeviceDescription;

  /// No description provided for @paiementReceived.
  ///
  /// In fr, this message translates to:
  /// **'Reçu'**
  String get paiementReceived;

  /// No description provided for @paiementRefund.
  ///
  /// In fr, this message translates to:
  /// **'Remboursement'**
  String get paiementRefund;

  /// No description provided for @paiementRefundAction.
  ///
  /// In fr, this message translates to:
  /// **'Rembourser'**
  String get paiementRefundAction;

  /// No description provided for @paiementRefundedThe.
  ///
  /// In fr, this message translates to:
  /// **'Remboursé le'**
  String get paiementRefundedThe;

  /// No description provided for @paiementRevokeDevice.
  ///
  /// In fr, this message translates to:
  /// **'Révoquer l\'appareil ?'**
  String get paiementRevokeDevice;

  /// No description provided for @paiementRevokeDeviceDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne pourrez plus utiliser cet appareil pour les paiements'**
  String get paiementRevokeDeviceDescription;

  /// No description provided for @paiementRightsOf.
  ///
  /// In fr, this message translates to:
  /// **'Droits de'**
  String get paiementRightsOf;

  /// No description provided for @paiementRightsUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Droits mis à jour'**
  String get paiementRightsUpdated;

  /// No description provided for @paiementRightsUpdateError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la mise à jour des droits'**
  String get paiementRightsUpdateError;

  /// No description provided for @paiementScan.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get paiementScan;

  /// No description provided for @paiementScanAlreadyUsedQRCode.
  ///
  /// In fr, this message translates to:
  /// **'QR Code déjà utilisé'**
  String get paiementScanAlreadyUsedQRCode;

  /// No description provided for @paiementScanCode.
  ///
  /// In fr, this message translates to:
  /// **'Scanner un code'**
  String get paiementScanCode;

  /// No description provided for @paiementScanNoMembership.
  ///
  /// In fr, this message translates to:
  /// **'Pas d\'adhésion'**
  String get paiementScanNoMembership;

  /// No description provided for @paiementScanNoMembershipConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Ce produit n\'est pas disponnible pour les non-adhérents. Confirmer l\'encaissement ?'**
  String get paiementScanNoMembershipConfirmation;

  /// No description provided for @paiementSeeHistory.
  ///
  /// In fr, this message translates to:
  /// **'Voir l\'historique'**
  String get paiementSeeHistory;

  /// No description provided for @paiementSelectStructure.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une structure'**
  String get paiementSelectStructure;

  /// No description provided for @paiementSellerError.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'êtes pas vendeur de ce magasin'**
  String get paiementSellerError;

  /// No description provided for @paiementSellerRigths.
  ///
  /// In fr, this message translates to:
  /// **'Droits du vendeur'**
  String get paiementSellerRigths;

  /// No description provided for @paiementSellersOf.
  ///
  /// In fr, this message translates to:
  /// **'Les vendeurs de'**
  String get paiementSellersOf;

  /// No description provided for @paiementSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get paiementSettings;

  /// No description provided for @paiementSpent.
  ///
  /// In fr, this message translates to:
  /// **'Déboursé'**
  String get paiementSpent;

  /// No description provided for @paiementStats.
  ///
  /// In fr, this message translates to:
  /// **'Stats'**
  String get paiementStats;

  /// No description provided for @paiementStoreBalance.
  ///
  /// In fr, this message translates to:
  /// **'Solde du magasin'**
  String get paiementStoreBalance;

  /// No description provided for @paiementStoreDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Magasin supprimée'**
  String get paiementStoreDeleted;

  /// Gestion de la structure
  ///
  /// In fr, this message translates to:
  /// **'Gestion de {structure}'**
  String paiementStructureManagement(String structure);

  /// No description provided for @paiementStoreName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du magasin'**
  String get paiementStoreName;

  /// No description provided for @paiementStores.
  ///
  /// In fr, this message translates to:
  /// **'Magasins'**
  String get paiementStores;

  /// No description provided for @paiementStructureAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur de la structure'**
  String get paiementStructureAdmin;

  /// No description provided for @paiementSuccededTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Paiement réussi'**
  String get paiementSuccededTransaction;

  /// No description provided for @paiementSuccessfullyAddedStore.
  ///
  /// In fr, this message translates to:
  /// **'Magasin ajoutée avec succès'**
  String get paiementSuccessfullyAddedStore;

  /// No description provided for @paiementSuccessfullyModifiedStore.
  ///
  /// In fr, this message translates to:
  /// **'Magasin modifiée avec succès'**
  String get paiementSuccessfullyModifiedStore;

  /// No description provided for @paiementThe.
  ///
  /// In fr, this message translates to:
  /// **'Le'**
  String get paiementThe;

  /// No description provided for @paiementThisDevice.
  ///
  /// In fr, this message translates to:
  /// **'(cet appareil)'**
  String get paiementThisDevice;

  /// No description provided for @paiementTopUp.
  ///
  /// In fr, this message translates to:
  /// **'Recharge'**
  String get paiementTopUp;

  /// No description provided for @paiementTopUpAction.
  ///
  /// In fr, this message translates to:
  /// **'Recharger'**
  String get paiementTopUpAction;

  /// No description provided for @paiementTotalDuringPeriod.
  ///
  /// In fr, this message translates to:
  /// **'Total sur la période'**
  String get paiementTotalDuringPeriod;

  /// No description provided for @paiementTransaction.
  ///
  /// In fr, this message translates to:
  /// **'ransaction'**
  String get paiementTransaction;

  /// No description provided for @paiementTransactionCancelled.
  ///
  /// In fr, this message translates to:
  /// **'Transaction annulée'**
  String get paiementTransactionCancelled;

  /// No description provided for @paiementTransactionCancelledDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment annuler la transaction de'**
  String get paiementTransactionCancelledDescription;

  /// No description provided for @paiementTransactionCancelledError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'annulation de la transaction'**
  String get paiementTransactionCancelledError;

  /// No description provided for @paiementTransferStructure.
  ///
  /// In fr, this message translates to:
  /// **'Transfert de structure'**
  String get paiementTransferStructure;

  /// No description provided for @paiementTransferStructureDescription.
  ///
  /// In fr, this message translates to:
  /// **'Le nouveau responsable aura accès à toutes les fonctionnalités de gestion de la structure. Vous allez recevoir un email pour valider ce transfert. Le lien ne sera actif que pendant 20 minutes. Cette action est irréversible. Êtes-vous sûr de vouloir continuer ?'**
  String get paiementTransferStructureDescription;

  /// No description provided for @paiementTransferStructureError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du transfert de la structure'**
  String get paiementTransferStructureError;

  /// No description provided for @paiementTransferStructureSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Transfert de structure demandé avec succès'**
  String get paiementTransferStructureSuccess;

  /// No description provided for @paiementUnknownDevice.
  ///
  /// In fr, this message translates to:
  /// **'Appareil inconnu'**
  String get paiementUnknownDevice;

  /// No description provided for @paiementValidUntil.
  ///
  /// In fr, this message translates to:
  /// **'Valide jusqu\'à'**
  String get paiementValidUntil;

  /// No description provided for @paiementYouAreTransferingStructureTo.
  ///
  /// In fr, this message translates to:
  /// **'Vous êtes sur le point de transférer la structure à '**
  String get paiementYouAreTransferingStructureTo;

  /// No description provided for @phAddNewJournal.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un nouveau journal'**
  String get phAddNewJournal;

  /// No description provided for @phNameField.
  ///
  /// In fr, this message translates to:
  /// **'Nom : '**
  String get phNameField;

  /// No description provided for @phDateField.
  ///
  /// In fr, this message translates to:
  /// **'Date : '**
  String get phDateField;

  /// No description provided for @phDelete.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer ce journal ?'**
  String get phDelete;

  /// No description provided for @phIrreversibleAction.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible'**
  String get phIrreversibleAction;

  /// No description provided for @phToHeavyFile.
  ///
  /// In fr, this message translates to:
  /// **'Fichier trop volumineux'**
  String get phToHeavyFile;

  /// No description provided for @phAddPdfFile.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un fichier PDF'**
  String get phAddPdfFile;

  /// No description provided for @phEditPdfFile.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le fichier PDF'**
  String get phEditPdfFile;

  /// No description provided for @phPhName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du PH'**
  String get phPhName;

  /// No description provided for @phDate.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get phDate;

  /// No description provided for @phAdded.
  ///
  /// In fr, this message translates to:
  /// **'Ajouté'**
  String get phAdded;

  /// No description provided for @phEdited.
  ///
  /// In fr, this message translates to:
  /// **'Modifié'**
  String get phEdited;

  /// No description provided for @phAddingFileError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur d\'ajout'**
  String get phAddingFileError;

  /// No description provided for @phMissingInformatonsOrPdf.
  ///
  /// In fr, this message translates to:
  /// **'Informations manquantes ou fichier PDF manquant'**
  String get phMissingInformatonsOrPdf;

  /// No description provided for @phAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get phAdd;

  /// No description provided for @phEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get phEdit;

  /// No description provided for @phSeePreviousJournal.
  ///
  /// In fr, this message translates to:
  /// **'Voir les anciens journaux'**
  String get phSeePreviousJournal;

  /// No description provided for @phNoJournalInDatabase.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de PH dans la base de donnée'**
  String get phNoJournalInDatabase;

  /// No description provided for @phSuccesDowloading.
  ///
  /// In fr, this message translates to:
  /// **'Téléchargé avec succès'**
  String get phSuccesDowloading;

  /// No description provided for @phonebookAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get phonebookAdd;

  /// No description provided for @phonebookAddAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une association'**
  String get phonebookAddAssociation;

  /// No description provided for @phonebookAddAssociationGroupement.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un groupement d\'association'**
  String get phonebookAddAssociationGroupement;

  /// No description provided for @phonebookAddedAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association ajoutée'**
  String get phonebookAddedAssociation;

  /// No description provided for @phonebookAddedMember.
  ///
  /// In fr, this message translates to:
  /// **'Membre ajouté'**
  String get phonebookAddedMember;

  /// No description provided for @phonebookAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get phonebookAddingError;

  /// No description provided for @phonebookAddMember.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un membre'**
  String get phonebookAddMember;

  /// No description provided for @phonebookAddRole.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un rôle'**
  String get phonebookAddRole;

  /// No description provided for @phonebookAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Admin'**
  String get phonebookAdmin;

  /// No description provided for @phonebookAll.
  ///
  /// In fr, this message translates to:
  /// **'Toutes'**
  String get phonebookAll;

  /// No description provided for @phonebookApparentName.
  ///
  /// In fr, this message translates to:
  /// **'Nom public du rôle :'**
  String get phonebookApparentName;

  /// No description provided for @phonebookAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association'**
  String get phonebookAssociation;

  /// No description provided for @phonebookAssociationDetail.
  ///
  /// In fr, this message translates to:
  /// **'Détail de l\'association :'**
  String get phonebookAssociationDetail;

  /// No description provided for @phonebookAssociationGroupement.
  ///
  /// In fr, this message translates to:
  /// **'Groupement d\'association'**
  String get phonebookAssociationGroupement;

  /// No description provided for @phonebookAssociationKind.
  ///
  /// In fr, this message translates to:
  /// **'Type d\'association :'**
  String get phonebookAssociationKind;

  /// No description provided for @phonebookAssociationName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'association'**
  String get phonebookAssociationName;

  /// No description provided for @phonebookAssociations.
  ///
  /// In fr, this message translates to:
  /// **'Associations'**
  String get phonebookAssociations;

  /// No description provided for @phonebookCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get phonebookCancel;

  /// Permet de changer le mandat d'une association
  ///
  /// In fr, this message translates to:
  /// **'Passer au mandat {year}'**
  String phonebookChangeTermYear(int year);

  /// No description provided for @phonebookChangeTermConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir changer tout le mandat ?\nCette action est irréversible !'**
  String get phonebookChangeTermConfirm;

  /// No description provided for @phonebookClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get phonebookClose;

  /// No description provided for @phonebookConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get phonebookConfirm;

  /// No description provided for @phonebookCopied.
  ///
  /// In fr, this message translates to:
  /// **'Copié dans le presse-papier'**
  String get phonebookCopied;

  /// No description provided for @phonebookDeactivateAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Désactiver l\'association'**
  String get phonebookDeactivateAssociation;

  /// No description provided for @phonebookDeactivatedAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association désactivée'**
  String get phonebookDeactivatedAssociation;

  /// No description provided for @phonebookDeactivatedAssociationWarning.
  ///
  /// In fr, this message translates to:
  /// **'Attention, cette association est désactivée, vous ne pouvez pas la modifier'**
  String get phonebookDeactivatedAssociationWarning;

  /// Permet de désactiver une association
  ///
  /// In fr, this message translates to:
  /// **'Désactiver l\'association {association} ?'**
  String phonebookDeactivateSelectedAssociation(String association);

  /// No description provided for @phonebookDeactivatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la désactivation'**
  String get phonebookDeactivatingError;

  /// No description provided for @phonebookDetail.
  ///
  /// In fr, this message translates to:
  /// **'Détail :'**
  String get phonebookDetail;

  /// No description provided for @phonebookDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get phonebookDelete;

  /// No description provided for @phonebookDeleteAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'association'**
  String get phonebookDeleteAssociation;

  /// Permet de supprimer une association
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'association {association} ?'**
  String phonebookDeleteSelectedAssociation(String association);

  /// No description provided for @phonebookDeleteAssociationDescription.
  ///
  /// In fr, this message translates to:
  /// **'Ceci va supprimer l\'historique de l\'association'**
  String get phonebookDeleteAssociationDescription;

  /// No description provided for @phonebookDeletedAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association supprimée'**
  String get phonebookDeletedAssociation;

  /// No description provided for @phonebookDeletedMember.
  ///
  /// In fr, this message translates to:
  /// **'Membre supprimé'**
  String get phonebookDeletedMember;

  /// No description provided for @phonebookDeleteRole.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le rôle'**
  String get phonebookDeleteRole;

  /// Permet de supprimer le rôle d'un utilisateur dans une association
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le rôle de l\'utilisateur {name} ?'**
  String phonebookDeleteUserRole(String name);

  /// No description provided for @phonebookDeactivating.
  ///
  /// In fr, this message translates to:
  /// **'Désactiver l\'association ?'**
  String get phonebookDeactivating;

  /// No description provided for @phonebookDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get phonebookDeleting;

  /// No description provided for @phonebookDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get phonebookDeletingError;

  /// No description provided for @phonebookDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get phonebookDescription;

  /// No description provided for @phonebookEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get phonebookEdit;

  /// No description provided for @phonebookEditAssociationGroupement.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le groupement d\'association'**
  String get phonebookEditAssociationGroupement;

  /// No description provided for @phonebookEditAssociationGroups.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les groupes'**
  String get phonebookEditAssociationGroups;

  /// No description provided for @phonebookEditAssociationInfo.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get phonebookEditAssociationInfo;

  /// No description provided for @phonebookEditAssociationMembers.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les membres'**
  String get phonebookEditAssociationMembers;

  /// No description provided for @phonebookEditRole.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le rôle'**
  String get phonebookEditRole;

  /// No description provided for @phonebookEditMembership.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le rôle'**
  String get phonebookEditMembership;

  /// No description provided for @phonebookEmail.
  ///
  /// In fr, this message translates to:
  /// **'Email :'**
  String get phonebookEmail;

  /// No description provided for @phonebookEmailCopied.
  ///
  /// In fr, this message translates to:
  /// **'Email copié dans le presse-papier'**
  String get phonebookEmailCopied;

  /// No description provided for @phonebookEmptyApparentName.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nom de role'**
  String get phonebookEmptyApparentName;

  /// No description provided for @phonebookEmptyFieldError.
  ///
  /// In fr, this message translates to:
  /// **'Un champ n\'est pas rempli'**
  String get phonebookEmptyFieldError;

  /// No description provided for @phonebookEmptyKindError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir un type d\'association'**
  String get phonebookEmptyKindError;

  /// No description provided for @phonebookEmptyMember.
  ///
  /// In fr, this message translates to:
  /// **'Aucun membre sélectionné'**
  String get phonebookEmptyMember;

  /// No description provided for @phonebookErrorAssociationLoading.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement de l\'association'**
  String get phonebookErrorAssociationLoading;

  /// No description provided for @phonebookErrorAssociationNameEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nom d\'association'**
  String get phonebookErrorAssociationNameEmpty;

  /// No description provided for @phonebookErrorAssociationPicture.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification de la photo d\'association'**
  String get phonebookErrorAssociationPicture;

  /// No description provided for @phonebookErrorKindsLoading.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des types d\'association'**
  String get phonebookErrorKindsLoading;

  /// No description provided for @phonebookErrorLoadAssociationList.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement de la liste des associations'**
  String get phonebookErrorLoadAssociationList;

  /// No description provided for @phonebookErrorLoadAssociationMember.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des membres de l\'association'**
  String get phonebookErrorLoadAssociationMember;

  /// No description provided for @phonebookErrorLoadAssociationPicture.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement de la photo d\'association'**
  String get phonebookErrorLoadAssociationPicture;

  /// No description provided for @phonebookErrorLoadProfilePicture.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get phonebookErrorLoadProfilePicture;

  /// No description provided for @phonebookErrorRoleTagsLoading.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des tags de rôle'**
  String get phonebookErrorRoleTagsLoading;

  /// No description provided for @phonebookExistingMembership.
  ///
  /// In fr, this message translates to:
  /// **'Ce membre est déjà dans le mandat actuel'**
  String get phonebookExistingMembership;

  /// No description provided for @phonebookFilter.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer'**
  String get phonebookFilter;

  /// No description provided for @phonebookFilterDescription.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer les associations par type'**
  String get phonebookFilterDescription;

  /// No description provided for @phonebookFirstname.
  ///
  /// In fr, this message translates to:
  /// **'Prénom :'**
  String get phonebookFirstname;

  /// No description provided for @phonebookGroupementDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Groupement d\'association supprimé'**
  String get phonebookGroupementDeleted;

  /// No description provided for @phonebookGroupementDeleteError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression du groupement d\'association'**
  String get phonebookGroupementDeleteError;

  /// No description provided for @phonebookGroupementName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du groupement'**
  String get phonebookGroupementName;

  /// Permet de gérer les groupes d'une association
  ///
  /// In fr, this message translates to:
  /// **'Gérer les groupes de {association}'**
  String phonebookGroups(String association);

  /// Année de mandat d'une association
  ///
  /// In fr, this message translates to:
  /// **'Mandat {year}'**
  String phonebookTerm(int year);

  /// No description provided for @phonebookTermChangingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du changement de mandat'**
  String get phonebookTermChangingError;

  /// No description provided for @phonebookMember.
  ///
  /// In fr, this message translates to:
  /// **'Membre'**
  String get phonebookMember;

  /// No description provided for @phonebookMemberReordered.
  ///
  /// In fr, this message translates to:
  /// **'Membre réordonné'**
  String get phonebookMemberReordered;

  /// Permet de gérer les membres d'une association
  ///
  /// In fr, this message translates to:
  /// **'Gérer les membres de {association}'**
  String phonebookMembers(String association);

  /// No description provided for @phonebookMembershipAssociationError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir une association'**
  String get phonebookMembershipAssociationError;

  /// No description provided for @phonebookMembershipRole.
  ///
  /// In fr, this message translates to:
  /// **'Rôle :'**
  String get phonebookMembershipRole;

  /// No description provided for @phonebookMembershipRoleError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir un rôle'**
  String get phonebookMembershipRoleError;

  /// Permet de modifier le rôle d'un membre dans une association
  ///
  /// In fr, this message translates to:
  /// **'Modifier le rôle de {name}'**
  String phonebookModifyMembership(String name);

  /// No description provided for @phonebookName.
  ///
  /// In fr, this message translates to:
  /// **'Nom :'**
  String get phonebookName;

  /// No description provided for @phonebookNameCopied.
  ///
  /// In fr, this message translates to:
  /// **'Nom et prénom copié dans le presse-papier'**
  String get phonebookNameCopied;

  /// No description provided for @phonebookNamePure.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get phonebookNamePure;

  /// No description provided for @phonebookNewTerm.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau mandat'**
  String get phonebookNewTerm;

  /// No description provided for @phonebookNewTermConfirmed.
  ///
  /// In fr, this message translates to:
  /// **'Mandat changé'**
  String get phonebookNewTermConfirmed;

  /// No description provided for @phonebookNickname.
  ///
  /// In fr, this message translates to:
  /// **'Surnom :'**
  String get phonebookNickname;

  /// No description provided for @phonebookNicknameCopied.
  ///
  /// In fr, this message translates to:
  /// **'Surnom copié dans le presse-papier'**
  String get phonebookNicknameCopied;

  /// No description provided for @phonebookNoAssociationFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucune association trouvée'**
  String get phonebookNoAssociationFound;

  /// No description provided for @phonebookNoMember.
  ///
  /// In fr, this message translates to:
  /// **'Aucun membre'**
  String get phonebookNoMember;

  /// No description provided for @phonebookNoMemberRole.
  ///
  /// In fr, this message translates to:
  /// **'Aucun role trouvé'**
  String get phonebookNoMemberRole;

  /// No description provided for @phonebookNoRoleTags.
  ///
  /// In fr, this message translates to:
  /// **'Aucun tag de rôle trouvé'**
  String get phonebookNoRoleTags;

  /// No description provided for @phonebookPhone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone :'**
  String get phonebookPhone;

  /// No description provided for @phonebookPhonebook.
  ///
  /// In fr, this message translates to:
  /// **'Annuaire'**
  String get phonebookPhonebook;

  /// No description provided for @phonebookPhonebookSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get phonebookPhonebookSearch;

  /// No description provided for @phonebookPhonebookSearchAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association'**
  String get phonebookPhonebookSearchAssociation;

  /// No description provided for @phonebookPhonebookSearchField.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher :'**
  String get phonebookPhonebookSearchField;

  /// No description provided for @phonebookPhonebookSearchName.
  ///
  /// In fr, this message translates to:
  /// **'Nom/Prénom/Surnom'**
  String get phonebookPhonebookSearchName;

  /// No description provided for @phonebookPhonebookSearchRole.
  ///
  /// In fr, this message translates to:
  /// **'Poste'**
  String get phonebookPhonebookSearchRole;

  /// No description provided for @phonebookPresidentRoleTag.
  ///
  /// In fr, this message translates to:
  /// **'Prez\''**
  String get phonebookPresidentRoleTag;

  /// No description provided for @phonebookPromoNotGiven.
  ///
  /// In fr, this message translates to:
  /// **'Promo non renseignée'**
  String get phonebookPromoNotGiven;

  /// Année de promotion d'un membre
  ///
  /// In fr, this message translates to:
  /// **'Promotion {year}'**
  String phonebookPromotion(int year);

  /// No description provided for @phonebookReorderingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du réordonnement'**
  String get phonebookReorderingError;

  /// No description provided for @phonebookResearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get phonebookResearch;

  /// No description provided for @phonebookRolePure.
  ///
  /// In fr, this message translates to:
  /// **'Rôle'**
  String get phonebookRolePure;

  /// No description provided for @phonebookSearchUser.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un utilisateur'**
  String get phonebookSearchUser;

  /// No description provided for @phonebookTooHeavyAssociationPicture.
  ///
  /// In fr, this message translates to:
  /// **'L\'image est trop lourde (max 4Mo)'**
  String get phonebookTooHeavyAssociationPicture;

  /// No description provided for @phonebookUpdateGroups.
  ///
  /// In fr, this message translates to:
  /// **'Mettre à jour les groupes'**
  String get phonebookUpdateGroups;

  /// No description provided for @phonebookUpdatedAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association modifiée'**
  String get phonebookUpdatedAssociation;

  /// No description provided for @phonebookUpdatedAssociationPicture.
  ///
  /// In fr, this message translates to:
  /// **'La photo d\'association a été changée'**
  String get phonebookUpdatedAssociationPicture;

  /// No description provided for @phonebookUpdatedGroups.
  ///
  /// In fr, this message translates to:
  /// **'Groupes mis à jour'**
  String get phonebookUpdatedGroups;

  /// No description provided for @phonebookUpdatedMember.
  ///
  /// In fr, this message translates to:
  /// **'Membre modifié'**
  String get phonebookUpdatedMember;

  /// No description provided for @phonebookUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get phonebookUpdatingError;

  /// No description provided for @phonebookValidation.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get phonebookValidation;

  /// No description provided for @purchasesPurchases.
  ///
  /// In fr, this message translates to:
  /// **'Achats'**
  String get purchasesPurchases;

  /// No description provided for @purchasesResearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get purchasesResearch;

  /// No description provided for @purchasesNoPurchasesFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun achat trouvé'**
  String get purchasesNoPurchasesFound;

  /// No description provided for @purchasesNoTickets.
  ///
  /// In fr, this message translates to:
  /// **'Aucun ticket'**
  String get purchasesNoTickets;

  /// No description provided for @purchasesTicketsError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des tickets'**
  String get purchasesTicketsError;

  /// No description provided for @purchasesPurchasesError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des achats'**
  String get purchasesPurchasesError;

  /// No description provided for @purchasesNoPurchases.
  ///
  /// In fr, this message translates to:
  /// **'Aucun achat'**
  String get purchasesNoPurchases;

  /// No description provided for @purchasesTimes.
  ///
  /// In fr, this message translates to:
  /// **'fois'**
  String get purchasesTimes;

  /// No description provided for @purchasesAlreadyUsed.
  ///
  /// In fr, this message translates to:
  /// **'Déjà utilisé'**
  String get purchasesAlreadyUsed;

  /// No description provided for @purchasesNotPaid.
  ///
  /// In fr, this message translates to:
  /// **'Non validé'**
  String get purchasesNotPaid;

  /// No description provided for @purchasesPleaseSelectProduct.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez sélectionner un produit'**
  String get purchasesPleaseSelectProduct;

  /// No description provided for @purchasesProducts.
  ///
  /// In fr, this message translates to:
  /// **'Produits'**
  String get purchasesProducts;

  /// No description provided for @purchasesCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get purchasesCancel;

  /// No description provided for @purchasesValidate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get purchasesValidate;

  /// No description provided for @purchasesLeftScan.
  ///
  /// In fr, this message translates to:
  /// **'Scans restants'**
  String get purchasesLeftScan;

  /// No description provided for @purchasesTag.
  ///
  /// In fr, this message translates to:
  /// **'Tag'**
  String get purchasesTag;

  /// No description provided for @purchasesHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get purchasesHistory;

  /// No description provided for @purchasesPleaseSelectSeller.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez sélectionner un vendeur'**
  String get purchasesPleaseSelectSeller;

  /// No description provided for @purchasesNoTagGiven.
  ///
  /// In fr, this message translates to:
  /// **'Attention, aucun tag n\'a été entré'**
  String get purchasesNoTagGiven;

  /// No description provided for @purchasesTickets.
  ///
  /// In fr, this message translates to:
  /// **'Tickets'**
  String get purchasesTickets;

  /// No description provided for @purchasesNoScannableProducts.
  ///
  /// In fr, this message translates to:
  /// **'Aucun produit scannable'**
  String get purchasesNoScannableProducts;

  /// No description provided for @purchasesLoading.
  ///
  /// In fr, this message translates to:
  /// **'En attente de scan'**
  String get purchasesLoading;

  /// No description provided for @purchasesScan.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get purchasesScan;

  /// No description provided for @raffleRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Tombola'**
  String get raffleRaffle;

  /// No description provided for @rafflePrize.
  ///
  /// In fr, this message translates to:
  /// **'Lot'**
  String get rafflePrize;

  /// No description provided for @rafflePrizes.
  ///
  /// In fr, this message translates to:
  /// **'Lots'**
  String get rafflePrizes;

  /// No description provided for @raffleActualRaffles.
  ///
  /// In fr, this message translates to:
  /// **'Tombola en cours'**
  String get raffleActualRaffles;

  /// No description provided for @rafflePastRaffles.
  ///
  /// In fr, this message translates to:
  /// **'Tombola passés'**
  String get rafflePastRaffles;

  /// No description provided for @raffleYourTickets.
  ///
  /// In fr, this message translates to:
  /// **'Tous vos tickets'**
  String get raffleYourTickets;

  /// No description provided for @raffleCreateMenu.
  ///
  /// In fr, this message translates to:
  /// **'Menu de Création'**
  String get raffleCreateMenu;

  /// No description provided for @raffleNextRaffles.
  ///
  /// In fr, this message translates to:
  /// **'Prochaines tombolas'**
  String get raffleNextRaffles;

  /// No description provided for @raffleNoTicket.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez pas de ticket'**
  String get raffleNoTicket;

  /// No description provided for @raffleSeeRaffleDetail.
  ///
  /// In fr, this message translates to:
  /// **'Voir lots/tickets'**
  String get raffleSeeRaffleDetail;

  /// No description provided for @raffleActualPrize.
  ///
  /// In fr, this message translates to:
  /// **'Lots actuels'**
  String get raffleActualPrize;

  /// No description provided for @raffleMajorPrize.
  ///
  /// In fr, this message translates to:
  /// **'Lot Majeurs'**
  String get raffleMajorPrize;

  /// No description provided for @raffleTakeTickets.
  ///
  /// In fr, this message translates to:
  /// **'Prendre vos tickets'**
  String get raffleTakeTickets;

  /// No description provided for @raffleNoTicketBuyable.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne pouvez pas achetez de billets pour l\'instant'**
  String get raffleNoTicketBuyable;

  /// No description provided for @raffleNoCurrentPrize.
  ///
  /// In fr, this message translates to:
  /// **'Il n\'y a aucun lots actuellement'**
  String get raffleNoCurrentPrize;

  /// No description provided for @raffleModifTombola.
  ///
  /// In fr, this message translates to:
  /// **'Vous pouvez modifiez vos tombolas ou en créer de nouvelles, toute décision doit ensuite être prise par les admins'**
  String get raffleModifTombola;

  /// No description provided for @raffleCreateYourRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Votre menu de création de tombolas'**
  String get raffleCreateYourRaffle;

  /// No description provided for @rafflePossiblePrice.
  ///
  /// In fr, this message translates to:
  /// **'Prix possible'**
  String get rafflePossiblePrice;

  /// No description provided for @raffleInformation.
  ///
  /// In fr, this message translates to:
  /// **'Information et Statistiques'**
  String get raffleInformation;

  /// No description provided for @raffleAccounts.
  ///
  /// In fr, this message translates to:
  /// **'Comptes'**
  String get raffleAccounts;

  /// No description provided for @raffleAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get raffleAdd;

  /// No description provided for @raffleUpdatedAmount.
  ///
  /// In fr, this message translates to:
  /// **'Montant mis à jour'**
  String get raffleUpdatedAmount;

  /// No description provided for @raffleUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la mise à jour'**
  String get raffleUpdatingError;

  /// No description provided for @raffleDeletedPrize.
  ///
  /// In fr, this message translates to:
  /// **'Lot supprimé'**
  String get raffleDeletedPrize;

  /// No description provided for @raffleDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get raffleDeletingError;

  /// No description provided for @raffleQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get raffleQuantity;

  /// No description provided for @raffleClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get raffleClose;

  /// No description provided for @raffleOpen.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir'**
  String get raffleOpen;

  /// No description provided for @raffleAddTypeTicketSimple.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get raffleAddTypeTicketSimple;

  /// No description provided for @raffleAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get raffleAddingError;

  /// No description provided for @raffleEditTypeTicketSimple.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get raffleEditTypeTicketSimple;

  /// No description provided for @raffleFillField.
  ///
  /// In fr, this message translates to:
  /// **'Le champ ne peut pas être vide'**
  String get raffleFillField;

  /// No description provided for @raffleWaiting.
  ///
  /// In fr, this message translates to:
  /// **'Chargement'**
  String get raffleWaiting;

  /// No description provided for @raffleEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get raffleEditingError;

  /// No description provided for @raffleAddedTicket.
  ///
  /// In fr, this message translates to:
  /// **'Ticket ajouté'**
  String get raffleAddedTicket;

  /// No description provided for @raffleEditedTicket.
  ///
  /// In fr, this message translates to:
  /// **'Ticket modifié'**
  String get raffleEditedTicket;

  /// No description provided for @raffleAlreadyExistTicket.
  ///
  /// In fr, this message translates to:
  /// **'Le ticket existe déjà'**
  String get raffleAlreadyExistTicket;

  /// No description provided for @raffleNumberExpected.
  ///
  /// In fr, this message translates to:
  /// **'Un entier est attendu'**
  String get raffleNumberExpected;

  /// No description provided for @raffleDeletedTicket.
  ///
  /// In fr, this message translates to:
  /// **'Ticket supprimé'**
  String get raffleDeletedTicket;

  /// No description provided for @raffleAddPrize.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get raffleAddPrize;

  /// No description provided for @raffleEditPrize.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get raffleEditPrize;

  /// No description provided for @raffleOpenRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir la tombola'**
  String get raffleOpenRaffle;

  /// No description provided for @raffleCloseRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Fermer la tombola'**
  String get raffleCloseRaffle;

  /// No description provided for @raffleOpenRaffleDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vous allez ouvrir la tombola, les utilisateurs pourront acheter des tickets. Vous ne pourrez plus modifier la tombola. Êtes-vous sûr de vouloir continuer ?'**
  String get raffleOpenRaffleDescription;

  /// No description provided for @raffleCloseRaffleDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vous allez fermer la tombola, les utilisateurs ne pourront plus acheter de tickets. Êtes-vous sûr de vouloir continuer ?'**
  String get raffleCloseRaffleDescription;

  /// No description provided for @raffleNoCurrentRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Il n\'y a aucune tombola en cours'**
  String get raffleNoCurrentRaffle;

  /// No description provided for @raffleBoughtTicket.
  ///
  /// In fr, this message translates to:
  /// **'Ticket acheté'**
  String get raffleBoughtTicket;

  /// No description provided for @raffleDrawingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du tirage'**
  String get raffleDrawingError;

  /// No description provided for @raffleInvalidPrice.
  ///
  /// In fr, this message translates to:
  /// **'Le prix doit être supérieur à 0'**
  String get raffleInvalidPrice;

  /// No description provided for @raffleMustBePositive.
  ///
  /// In fr, this message translates to:
  /// **'Le nombre doit être strictement positif'**
  String get raffleMustBePositive;

  /// No description provided for @raffleDraw.
  ///
  /// In fr, this message translates to:
  /// **'Tirer'**
  String get raffleDraw;

  /// No description provided for @raffleDrawn.
  ///
  /// In fr, this message translates to:
  /// **'Tiré'**
  String get raffleDrawn;

  /// No description provided for @raffleError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get raffleError;

  /// No description provided for @raffleGathered.
  ///
  /// In fr, this message translates to:
  /// **'Récolté'**
  String get raffleGathered;

  /// No description provided for @raffleTickets.
  ///
  /// In fr, this message translates to:
  /// **'Tickets'**
  String get raffleTickets;

  /// No description provided for @raffleTicket.
  ///
  /// In fr, this message translates to:
  /// **'ticket'**
  String get raffleTicket;

  /// No description provided for @raffleWinner.
  ///
  /// In fr, this message translates to:
  /// **'Gagnant'**
  String get raffleWinner;

  /// No description provided for @raffleNoPrize.
  ///
  /// In fr, this message translates to:
  /// **'Aucun lot'**
  String get raffleNoPrize;

  /// No description provided for @raffleDeletePrize.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le lot'**
  String get raffleDeletePrize;

  /// No description provided for @raffleDeletePrizeDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vous allez supprimer le lot, êtes-vous sûr de vouloir continuer ?'**
  String get raffleDeletePrizeDescription;

  /// No description provided for @raffleDrawing.
  ///
  /// In fr, this message translates to:
  /// **'Tirage'**
  String get raffleDrawing;

  /// No description provided for @raffleDrawingDescription.
  ///
  /// In fr, this message translates to:
  /// **'Tirer le gagnant du lot ?'**
  String get raffleDrawingDescription;

  /// No description provided for @raffleDeleteTicket.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le ticket'**
  String get raffleDeleteTicket;

  /// No description provided for @raffleDeleteTicketDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vous allez supprimer le ticket, êtes-vous sûr de vouloir continuer ?'**
  String get raffleDeleteTicketDescription;

  /// No description provided for @raffleWinningTickets.
  ///
  /// In fr, this message translates to:
  /// **'Tickets gagnants'**
  String get raffleWinningTickets;

  /// No description provided for @raffleNoWinningTicketYet.
  ///
  /// In fr, this message translates to:
  /// **'Les tickets gagnants seront affichés ici'**
  String get raffleNoWinningTicketYet;

  /// No description provided for @raffleName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get raffleName;

  /// No description provided for @raffleDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get raffleDescription;

  /// No description provided for @raffleBuyThisTicket.
  ///
  /// In fr, this message translates to:
  /// **'Acheter ce ticket'**
  String get raffleBuyThisTicket;

  /// No description provided for @raffleLockedRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Tombola verrouillée'**
  String get raffleLockedRaffle;

  /// No description provided for @raffleUnavailableRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Tombola indisponible'**
  String get raffleUnavailableRaffle;

  /// No description provided for @raffleNotEnoughMoney.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez pas assez d\'argent'**
  String get raffleNotEnoughMoney;

  /// No description provided for @raffleWinnable.
  ///
  /// In fr, this message translates to:
  /// **'gagnable'**
  String get raffleWinnable;

  /// No description provided for @raffleNoDescription.
  ///
  /// In fr, this message translates to:
  /// **'Aucune description'**
  String get raffleNoDescription;

  /// No description provided for @raffleAmount.
  ///
  /// In fr, this message translates to:
  /// **'Solde'**
  String get raffleAmount;

  /// No description provided for @raffleLoading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement'**
  String get raffleLoading;

  /// No description provided for @raffleTicketNumber.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de ticket'**
  String get raffleTicketNumber;

  /// No description provided for @rafflePrice.
  ///
  /// In fr, this message translates to:
  /// **'Prix'**
  String get rafflePrice;

  /// No description provided for @raffleEditRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la tombola'**
  String get raffleEditRaffle;

  /// No description provided for @raffleEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get raffleEdit;

  /// No description provided for @raffleAddPackTicket.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un pack de ticket'**
  String get raffleAddPackTicket;

  /// No description provided for @recommendationRecommendation.
  ///
  /// In fr, this message translates to:
  /// **'Bons plans'**
  String get recommendationRecommendation;

  /// No description provided for @recommendationTitle.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get recommendationTitle;

  /// No description provided for @recommendationLogo.
  ///
  /// In fr, this message translates to:
  /// **'Logo'**
  String get recommendationLogo;

  /// No description provided for @recommendationCode.
  ///
  /// In fr, this message translates to:
  /// **'Code'**
  String get recommendationCode;

  /// No description provided for @recommendationSummary.
  ///
  /// In fr, this message translates to:
  /// **'Court résumé'**
  String get recommendationSummary;

  /// No description provided for @recommendationDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get recommendationDescription;

  /// No description provided for @recommendationAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get recommendationAdd;

  /// No description provided for @recommendationEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get recommendationEdit;

  /// No description provided for @recommendationDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get recommendationDelete;

  /// No description provided for @recommendationAddImage.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez ajouter une image'**
  String get recommendationAddImage;

  /// No description provided for @recommendationAddedRecommendation.
  ///
  /// In fr, this message translates to:
  /// **'Bon plan ajouté'**
  String get recommendationAddedRecommendation;

  /// No description provided for @recommendationEditedRecommendation.
  ///
  /// In fr, this message translates to:
  /// **'Bon plan modifié'**
  String get recommendationEditedRecommendation;

  /// No description provided for @recommendationDeleteRecommendationConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer ce bon plan ?'**
  String get recommendationDeleteRecommendationConfirmation;

  /// No description provided for @recommendationDeleteRecommendation.
  ///
  /// In fr, this message translates to:
  /// **'Suppresion'**
  String get recommendationDeleteRecommendation;

  /// No description provided for @recommendationDeletingRecommendationError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get recommendationDeletingRecommendationError;

  /// No description provided for @recommendationDeletedRecommendation.
  ///
  /// In fr, this message translates to:
  /// **'Bon plan supprimé'**
  String get recommendationDeletedRecommendation;

  /// No description provided for @recommendationIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Champs incorrects ou manquants'**
  String get recommendationIncorrectOrMissingFields;

  /// No description provided for @recommendationEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la modification'**
  String get recommendationEditingError;

  /// No description provided for @recommendationAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Échec de l\'ajout'**
  String get recommendationAddingError;

  /// No description provided for @recommendationCopiedCode.
  ///
  /// In fr, this message translates to:
  /// **'Code de réduction copié'**
  String get recommendationCopiedCode;

  /// No description provided for @seedLibraryAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get seedLibraryAdd;

  /// No description provided for @seedLibraryAddedPlant.
  ///
  /// In fr, this message translates to:
  /// **'Plante ajoutée'**
  String get seedLibraryAddedPlant;

  /// No description provided for @seedLibraryAddedSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Espèce ajoutée'**
  String get seedLibraryAddedSpecies;

  /// No description provided for @seedLibraryAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get seedLibraryAddingError;

  /// No description provided for @seedLibraryAddPlant.
  ///
  /// In fr, this message translates to:
  /// **'Déposer une plante'**
  String get seedLibraryAddPlant;

  /// No description provided for @seedLibraryAddSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une espèce'**
  String get seedLibraryAddSpecies;

  /// No description provided for @seedLibraryAll.
  ///
  /// In fr, this message translates to:
  /// **'Toutes'**
  String get seedLibraryAll;

  /// No description provided for @seedLibraryAncestor.
  ///
  /// In fr, this message translates to:
  /// **'Ancêtre'**
  String get seedLibraryAncestor;

  /// No description provided for @seedLibraryAround.
  ///
  /// In fr, this message translates to:
  /// **'environ'**
  String get seedLibraryAround;

  /// No description provided for @seedLibraryAutumn.
  ///
  /// In fr, this message translates to:
  /// **'Automne'**
  String get seedLibraryAutumn;

  /// No description provided for @seedLibraryBorrowedPlant.
  ///
  /// In fr, this message translates to:
  /// **'Plante empruntée'**
  String get seedLibraryBorrowedPlant;

  /// No description provided for @seedLibraryBorrowingDate.
  ///
  /// In fr, this message translates to:
  /// **'Date d\'emprunt :'**
  String get seedLibraryBorrowingDate;

  /// No description provided for @seedLibraryBorrowPlant.
  ///
  /// In fr, this message translates to:
  /// **'Emprunter la plante'**
  String get seedLibraryBorrowPlant;

  /// No description provided for @seedLibraryCard.
  ///
  /// In fr, this message translates to:
  /// **'Carte'**
  String get seedLibraryCard;

  /// No description provided for @seedLibraryChoosingAncestor.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir un ancêtre'**
  String get seedLibraryChoosingAncestor;

  /// No description provided for @seedLibraryChoosingSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir une espèce'**
  String get seedLibraryChoosingSpecies;

  /// No description provided for @seedLibraryChoosingSpeciesOrAncestor.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir une espèce ou un ancêtre'**
  String get seedLibraryChoosingSpeciesOrAncestor;

  /// No description provided for @seedLibraryContact.
  ///
  /// In fr, this message translates to:
  /// **'Contact :'**
  String get seedLibraryContact;

  /// No description provided for @seedLibraryDays.
  ///
  /// In fr, this message translates to:
  /// **'jours'**
  String get seedLibraryDays;

  /// No description provided for @seedLibraryDeadMsg.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous déclarer la plante morte ?'**
  String get seedLibraryDeadMsg;

  /// No description provided for @seedLibraryDeadPlant.
  ///
  /// In fr, this message translates to:
  /// **'Plante morte'**
  String get seedLibraryDeadPlant;

  /// No description provided for @seedLibraryDeathDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de mort'**
  String get seedLibraryDeathDate;

  /// No description provided for @seedLibraryDeletedSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Espèce supprimée'**
  String get seedLibraryDeletedSpecies;

  /// No description provided for @seedLibraryDeleteSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'espèce ?'**
  String get seedLibraryDeleteSpecies;

  /// No description provided for @seedLibraryDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppression'**
  String get seedLibraryDeleting;

  /// No description provided for @seedLibraryDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get seedLibraryDeletingError;

  /// No description provided for @seedLibraryDepositNotAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Le dépôt de plantes n\'est pas possible sans emprunter une plante au préalable'**
  String get seedLibraryDepositNotAvailable;

  /// No description provided for @seedLibraryDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get seedLibraryDescription;

  /// No description provided for @seedLibraryDifficulty.
  ///
  /// In fr, this message translates to:
  /// **'Difficulté :'**
  String get seedLibraryDifficulty;

  /// No description provided for @seedLibraryEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get seedLibraryEdit;

  /// No description provided for @seedLibraryEditedPlant.
  ///
  /// In fr, this message translates to:
  /// **'Plante modifiée'**
  String get seedLibraryEditedPlant;

  /// No description provided for @seedLibraryEditInformation.
  ///
  /// In fr, this message translates to:
  /// **'Modifier les informations'**
  String get seedLibraryEditInformation;

  /// No description provided for @seedLibraryEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get seedLibraryEditingError;

  /// No description provided for @seedLibraryEditSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'espèce'**
  String get seedLibraryEditSpecies;

  /// No description provided for @seedLibraryEmptyDifficultyError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir une difficulté'**
  String get seedLibraryEmptyDifficultyError;

  /// No description provided for @seedLibraryEmptyFieldError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez remplir tous les champs'**
  String get seedLibraryEmptyFieldError;

  /// No description provided for @seedLibraryEmptyTypeError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez choisir un type de plante'**
  String get seedLibraryEmptyTypeError;

  /// No description provided for @seedLibraryEndMonth.
  ///
  /// In fr, this message translates to:
  /// **'Mois de fin :'**
  String get seedLibraryEndMonth;

  /// No description provided for @seedLibraryFacebookUrl.
  ///
  /// In fr, this message translates to:
  /// **'Lien Facebook'**
  String get seedLibraryFacebookUrl;

  /// No description provided for @seedLibraryFilters.
  ///
  /// In fr, this message translates to:
  /// **'Filtres'**
  String get seedLibraryFilters;

  /// No description provided for @seedLibraryForum.
  ///
  /// In fr, this message translates to:
  /// **'Oskour maman j\'ai tué ma plante - Forum d\'aide'**
  String get seedLibraryForum;

  /// No description provided for @seedLibraryForumUrl.
  ///
  /// In fr, this message translates to:
  /// **'Lien Forum'**
  String get seedLibraryForumUrl;

  /// No description provided for @seedLibraryHelpSheets.
  ///
  /// In fr, this message translates to:
  /// **'Fiches sur les plantes'**
  String get seedLibraryHelpSheets;

  /// No description provided for @seedLibraryInformation.
  ///
  /// In fr, this message translates to:
  /// **'Informations :'**
  String get seedLibraryInformation;

  /// No description provided for @seedLibraryMaturationTime.
  ///
  /// In fr, this message translates to:
  /// **'Temps de maturation'**
  String get seedLibraryMaturationTime;

  /// No description provided for @seedLibraryMonthJan.
  ///
  /// In fr, this message translates to:
  /// **'Janvier'**
  String get seedLibraryMonthJan;

  /// No description provided for @seedLibraryMonthFeb.
  ///
  /// In fr, this message translates to:
  /// **'Février'**
  String get seedLibraryMonthFeb;

  /// No description provided for @seedLibraryMonthMar.
  ///
  /// In fr, this message translates to:
  /// **'Mars'**
  String get seedLibraryMonthMar;

  /// No description provided for @seedLibraryMonthApr.
  ///
  /// In fr, this message translates to:
  /// **'Avril'**
  String get seedLibraryMonthApr;

  /// No description provided for @seedLibraryMonthMay.
  ///
  /// In fr, this message translates to:
  /// **'Mai'**
  String get seedLibraryMonthMay;

  /// No description provided for @seedLibraryMonthJun.
  ///
  /// In fr, this message translates to:
  /// **'Juin'**
  String get seedLibraryMonthJun;

  /// No description provided for @seedLibraryMonthJul.
  ///
  /// In fr, this message translates to:
  /// **'Juillet'**
  String get seedLibraryMonthJul;

  /// No description provided for @seedLibraryMonthAug.
  ///
  /// In fr, this message translates to:
  /// **'Août'**
  String get seedLibraryMonthAug;

  /// No description provided for @seedLibraryMonthSep.
  ///
  /// In fr, this message translates to:
  /// **'Septembre'**
  String get seedLibraryMonthSep;

  /// No description provided for @seedLibraryMonthOct.
  ///
  /// In fr, this message translates to:
  /// **'Octobre'**
  String get seedLibraryMonthOct;

  /// No description provided for @seedLibraryMonthNov.
  ///
  /// In fr, this message translates to:
  /// **'Novembre'**
  String get seedLibraryMonthNov;

  /// No description provided for @seedLibraryMonthDec.
  ///
  /// In fr, this message translates to:
  /// **'Décembre'**
  String get seedLibraryMonthDec;

  /// No description provided for @seedLibraryMyPlants.
  ///
  /// In fr, this message translates to:
  /// **'Mes plantes'**
  String get seedLibraryMyPlants;

  /// No description provided for @seedLibraryName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get seedLibraryName;

  /// No description provided for @seedLibraryNbSeedsRecommended.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de graines recommandées'**
  String get seedLibraryNbSeedsRecommended;

  /// No description provided for @seedLibraryNbSeedsRecommendedError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nombre de graines recommandé supérieur à 0'**
  String get seedLibraryNbSeedsRecommendedError;

  /// No description provided for @seedLibraryNoDateError.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une date'**
  String get seedLibraryNoDateError;

  /// No description provided for @seedLibraryNoFilteredPlants.
  ///
  /// In fr, this message translates to:
  /// **'Aucune plante ne correspond à votre recherche. Essayez d\'autres filtres.'**
  String get seedLibraryNoFilteredPlants;

  /// No description provided for @seedLibraryNoMorePlant.
  ///
  /// In fr, this message translates to:
  /// **'Aucune plante n\'est disponible'**
  String get seedLibraryNoMorePlant;

  /// No description provided for @seedLibraryNoPersonalPlants.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez pas encore de plantes dans votre grainothèque. Vous pouvez en ajouter en allant dans les stocks.'**
  String get seedLibraryNoPersonalPlants;

  /// No description provided for @seedLibraryNoSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Aucune espèce trouvée'**
  String get seedLibraryNoSpecies;

  /// No description provided for @seedLibraryNoStockPlants.
  ///
  /// In fr, this message translates to:
  /// **'Aucune plante disponible dans le stock'**
  String get seedLibraryNoStockPlants;

  /// No description provided for @seedLibraryNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get seedLibraryNotes;

  /// No description provided for @seedLibraryOk.
  ///
  /// In fr, this message translates to:
  /// **'OK'**
  String get seedLibraryOk;

  /// No description provided for @seedLibraryPlantationPeriod.
  ///
  /// In fr, this message translates to:
  /// **'Période de plantation :'**
  String get seedLibraryPlantationPeriod;

  /// No description provided for @seedLibraryPlantationType.
  ///
  /// In fr, this message translates to:
  /// **'Type de plantation :'**
  String get seedLibraryPlantationType;

  /// No description provided for @seedLibraryPlantDetail.
  ///
  /// In fr, this message translates to:
  /// **'Détail de la plante'**
  String get seedLibraryPlantDetail;

  /// No description provided for @seedLibraryPlantingDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de plantation'**
  String get seedLibraryPlantingDate;

  /// No description provided for @seedLibraryPlantingNow.
  ///
  /// In fr, this message translates to:
  /// **'Je la plante maintenant'**
  String get seedLibraryPlantingNow;

  /// No description provided for @seedLibraryPrefix.
  ///
  /// In fr, this message translates to:
  /// **'Préfixe'**
  String get seedLibraryPrefix;

  /// No description provided for @seedLibraryPrefixError.
  ///
  /// In fr, this message translates to:
  /// **'Prefixe déjà utilisé'**
  String get seedLibraryPrefixError;

  /// No description provided for @seedLibraryPrefixLengthError.
  ///
  /// In fr, this message translates to:
  /// **'Le préfixe doit faire 3 caractères'**
  String get seedLibraryPrefixLengthError;

  /// No description provided for @seedLibraryPropagationMethod.
  ///
  /// In fr, this message translates to:
  /// **'Méthode de propagation :'**
  String get seedLibraryPropagationMethod;

  /// No description provided for @seedLibraryReference.
  ///
  /// In fr, this message translates to:
  /// **'Référence :'**
  String get seedLibraryReference;

  /// No description provided for @seedLibraryRemovedPlant.
  ///
  /// In fr, this message translates to:
  /// **'Plante supprimée'**
  String get seedLibraryRemovedPlant;

  /// No description provided for @seedLibraryRemovingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get seedLibraryRemovingError;

  /// No description provided for @seedLibraryResearch.
  ///
  /// In fr, this message translates to:
  /// **'Recherche'**
  String get seedLibraryResearch;

  /// No description provided for @seedLibrarySaveChanges.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder les modifications'**
  String get seedLibrarySaveChanges;

  /// No description provided for @seedLibrarySeason.
  ///
  /// In fr, this message translates to:
  /// **'Saison :'**
  String get seedLibrarySeason;

  /// No description provided for @seedLibrarySeed.
  ///
  /// In fr, this message translates to:
  /// **'Graine'**
  String get seedLibrarySeed;

  /// No description provided for @seedLibrarySeeds.
  ///
  /// In fr, this message translates to:
  /// **'graines'**
  String get seedLibrarySeeds;

  /// No description provided for @seedLibrarySeedDeposit.
  ///
  /// In fr, this message translates to:
  /// **'Dépôt de plantes'**
  String get seedLibrarySeedDeposit;

  /// No description provided for @seedLibrarySeedLibrary.
  ///
  /// In fr, this message translates to:
  /// **'Grainothèque'**
  String get seedLibrarySeedLibrary;

  /// No description provided for @seedLibrarySeedQuantitySimple.
  ///
  /// In fr, this message translates to:
  /// **'Quantité de graines'**
  String get seedLibrarySeedQuantitySimple;

  /// No description provided for @seedLibrarySeedQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité de graines :'**
  String get seedLibrarySeedQuantity;

  /// No description provided for @seedLibraryShowDeadPlants.
  ///
  /// In fr, this message translates to:
  /// **'Afficher les plantes mortes'**
  String get seedLibraryShowDeadPlants;

  /// No description provided for @seedLibrarySpecies.
  ///
  /// In fr, this message translates to:
  /// **'Espèce :'**
  String get seedLibrarySpecies;

  /// No description provided for @seedLibrarySpeciesHelp.
  ///
  /// In fr, this message translates to:
  /// **'Aide sur l\'espèce'**
  String get seedLibrarySpeciesHelp;

  /// No description provided for @seedLibrarySpeciesPlural.
  ///
  /// In fr, this message translates to:
  /// **'Espèces'**
  String get seedLibrarySpeciesPlural;

  /// No description provided for @seedLibrarySpeciesSimple.
  ///
  /// In fr, this message translates to:
  /// **'Espèce'**
  String get seedLibrarySpeciesSimple;

  /// No description provided for @seedLibrarySpeciesType.
  ///
  /// In fr, this message translates to:
  /// **'Type d\'espèce :'**
  String get seedLibrarySpeciesType;

  /// No description provided for @seedLibrarySpring.
  ///
  /// In fr, this message translates to:
  /// **'Printemps'**
  String get seedLibrarySpring;

  /// No description provided for @seedLibraryStartMonth.
  ///
  /// In fr, this message translates to:
  /// **'Mois de début :'**
  String get seedLibraryStartMonth;

  /// No description provided for @seedLibraryStock.
  ///
  /// In fr, this message translates to:
  /// **'Stock disponible'**
  String get seedLibraryStock;

  /// No description provided for @seedLibrarySummer.
  ///
  /// In fr, this message translates to:
  /// **'Été'**
  String get seedLibrarySummer;

  /// No description provided for @seedLibraryStocks.
  ///
  /// In fr, this message translates to:
  /// **'Stocks'**
  String get seedLibraryStocks;

  /// No description provided for @seedLibraryTimeUntilMaturation.
  ///
  /// In fr, this message translates to:
  /// **'Temps avant maturation :'**
  String get seedLibraryTimeUntilMaturation;

  /// No description provided for @seedLibraryType.
  ///
  /// In fr, this message translates to:
  /// **'Type :'**
  String get seedLibraryType;

  /// No description provided for @seedLibraryUnableToOpen.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'ouvrir le lien'**
  String get seedLibraryUnableToOpen;

  /// No description provided for @seedLibraryUpdate.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get seedLibraryUpdate;

  /// No description provided for @seedLibraryUpdatedInformation.
  ///
  /// In fr, this message translates to:
  /// **'Informations modifiées'**
  String get seedLibraryUpdatedInformation;

  /// No description provided for @seedLibraryUpdatedSpecies.
  ///
  /// In fr, this message translates to:
  /// **'Espèce modifiée'**
  String get seedLibraryUpdatedSpecies;

  /// No description provided for @seedLibraryUpdatedPlant.
  ///
  /// In fr, this message translates to:
  /// **'Plante modifiée'**
  String get seedLibraryUpdatedPlant;

  /// No description provided for @seedLibraryUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get seedLibraryUpdatingError;

  /// No description provided for @seedLibraryWinter.
  ///
  /// In fr, this message translates to:
  /// **'Hiver'**
  String get seedLibraryWinter;

  /// No description provided for @seedLibraryWriteReference.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez écrire la référence suivante : '**
  String get seedLibraryWriteReference;

  /// No description provided for @settingsAccount.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get settingsAccount;

  /// No description provided for @settingsAddProfilePicture.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une photo'**
  String get settingsAddProfilePicture;

  /// No description provided for @settingsAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur'**
  String get settingsAdmin;

  /// No description provided for @settingsAskHelp.
  ///
  /// In fr, this message translates to:
  /// **'Demander de l\'aide'**
  String get settingsAskHelp;

  /// No description provided for @settingsAssociation.
  ///
  /// In fr, this message translates to:
  /// **'Association'**
  String get settingsAssociation;

  /// No description provided for @settingsBirthday.
  ///
  /// In fr, this message translates to:
  /// **'Date de naissance'**
  String get settingsBirthday;

  /// No description provided for @settingsBugs.
  ///
  /// In fr, this message translates to:
  /// **'Bugs'**
  String get settingsBugs;

  /// No description provided for @settingsChangePassword.
  ///
  /// In fr, this message translates to:
  /// **'Changer de mot de passe'**
  String get settingsChangePassword;

  /// No description provided for @settingsChangingPassword.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment changer votre mot de passe ?'**
  String get settingsChangingPassword;

  /// No description provided for @settingsConfirmPassword.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le mot de passe'**
  String get settingsConfirmPassword;

  /// No description provided for @settingsCopied.
  ///
  /// In fr, this message translates to:
  /// **'Copié !'**
  String get settingsCopied;

  /// No description provided for @settingsDarkMode.
  ///
  /// In fr, this message translates to:
  /// **'Mode sombre'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeOff.
  ///
  /// In fr, this message translates to:
  /// **'Désactivé'**
  String get settingsDarkModeOff;

  /// No description provided for @settingsDeleteLogs.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer les logs ?'**
  String get settingsDeleteLogs;

  /// No description provided for @settingsDeleteNotificationLogs.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer les logs des notifications ?'**
  String get settingsDeleteNotificationLogs;

  /// No description provided for @settingsDetelePersonalData.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer mes données personnelles'**
  String get settingsDetelePersonalData;

  /// No description provided for @settingsDetelePersonalDataDesc.
  ///
  /// In fr, this message translates to:
  /// **'Cette action notifie l\'administrateur que vous souhaitez supprimer vos données personnelles.'**
  String get settingsDetelePersonalDataDesc;

  /// No description provided for @settingsDeleting.
  ///
  /// In fr, this message translates to:
  /// **'Suppresion'**
  String get settingsDeleting;

  /// No description provided for @settingsEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get settingsEdit;

  /// No description provided for @settingsEditAccount.
  ///
  /// In fr, this message translates to:
  /// **'Modifier mon profil'**
  String get settingsEditAccount;

  /// No description provided for @settingsEmail.
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get settingsEmail;

  /// No description provided for @settingsEmptyField.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ ne peut pas être vide'**
  String get settingsEmptyField;

  /// No description provided for @settingsErrorProfilePicture.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification de la photo de profil'**
  String get settingsErrorProfilePicture;

  /// No description provided for @settingsErrorSendingDemand.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'envoi de la demande'**
  String get settingsErrorSendingDemand;

  /// No description provided for @settingsEventsIcal.
  ///
  /// In fr, this message translates to:
  /// **'Lien Ical des événements'**
  String get settingsEventsIcal;

  /// No description provided for @settingsExpectingDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de naissance attendue'**
  String get settingsExpectingDate;

  /// No description provided for @settingsFirstname.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get settingsFirstname;

  /// No description provided for @settingsFloor.
  ///
  /// In fr, this message translates to:
  /// **'Étage'**
  String get settingsFloor;

  /// No description provided for @settingsHelp.
  ///
  /// In fr, this message translates to:
  /// **'Aide'**
  String get settingsHelp;

  /// No description provided for @settingsIcalCopied.
  ///
  /// In fr, this message translates to:
  /// **'Lien Ical copié !'**
  String get settingsIcalCopied;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageVar.
  ///
  /// In fr, this message translates to:
  /// **'Français 🇫🇷'**
  String get settingsLanguageVar;

  /// No description provided for @settingsLogs.
  ///
  /// In fr, this message translates to:
  /// **'Logs'**
  String get settingsLogs;

  /// No description provided for @settingsModules.
  ///
  /// In fr, this message translates to:
  /// **'Modules'**
  String get settingsModules;

  /// No description provided for @settingsMyIcs.
  ///
  /// In fr, this message translates to:
  /// **'Mon lien Ical'**
  String get settingsMyIcs;

  /// No description provided for @settingsName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get settingsName;

  /// No description provided for @settingsNewPassword.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau mot de passe'**
  String get settingsNewPassword;

  /// No description provided for @settingsNickname.
  ///
  /// In fr, this message translates to:
  /// **'Surnom'**
  String get settingsNickname;

  /// No description provided for @settingsNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsOldPassword.
  ///
  /// In fr, this message translates to:
  /// **'Ancien mot de passe'**
  String get settingsOldPassword;

  /// No description provided for @settingsPasswordChanged.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe changé'**
  String get settingsPasswordChanged;

  /// No description provided for @settingsPasswordsNotMatch.
  ///
  /// In fr, this message translates to:
  /// **'Les mots de passe ne correspondent pas'**
  String get settingsPasswordsNotMatch;

  /// No description provided for @settingsPersonalData.
  ///
  /// In fr, this message translates to:
  /// **'Données personnelles'**
  String get settingsPersonalData;

  /// No description provided for @settingsPersonalisation.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisation'**
  String get settingsPersonalisation;

  /// No description provided for @settingsPhone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get settingsPhone;

  /// No description provided for @settingsProfilePicture.
  ///
  /// In fr, this message translates to:
  /// **'Photo de profil'**
  String get settingsProfilePicture;

  /// No description provided for @settingsPromo.
  ///
  /// In fr, this message translates to:
  /// **'Promotion'**
  String get settingsPromo;

  /// No description provided for @settingsRepportBug.
  ///
  /// In fr, this message translates to:
  /// **'Signaler un bug'**
  String get settingsRepportBug;

  /// No description provided for @settingsSave.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get settingsSave;

  /// No description provided for @settingsSecurity.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get settingsSecurity;

  /// No description provided for @settingsSendedDemand.
  ///
  /// In fr, this message translates to:
  /// **'Demande envoyée'**
  String get settingsSendedDemand;

  /// No description provided for @settingsSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsSettings;

  /// No description provided for @settingsTooHeavyProfilePicture.
  ///
  /// In fr, this message translates to:
  /// **'L\'image est trop lourde (max 4Mo)'**
  String get settingsTooHeavyProfilePicture;

  /// No description provided for @settingsUpdatedProfile.
  ///
  /// In fr, this message translates to:
  /// **'Profil modifié'**
  String get settingsUpdatedProfile;

  /// No description provided for @settingsUpdatedProfilePicture.
  ///
  /// In fr, this message translates to:
  /// **'Photo de profil modifiée'**
  String get settingsUpdatedProfilePicture;

  /// No description provided for @settingsUpdateNotification.
  ///
  /// In fr, this message translates to:
  /// **'Mettre à jour les notifications'**
  String get settingsUpdateNotification;

  /// No description provided for @settingsUpdatingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification du profil'**
  String get settingsUpdatingError;

  /// No description provided for @settingsVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsPasswordStrength.
  ///
  /// In fr, this message translates to:
  /// **'Force du mot de passe'**
  String get settingsPasswordStrength;

  /// No description provided for @settingsPasswordStrengthVeryWeak.
  ///
  /// In fr, this message translates to:
  /// **'Très faible'**
  String get settingsPasswordStrengthVeryWeak;

  /// No description provided for @settingsPasswordStrengthWeak.
  ///
  /// In fr, this message translates to:
  /// **'Faible'**
  String get settingsPasswordStrengthWeak;

  /// No description provided for @settingsPasswordStrengthMedium.
  ///
  /// In fr, this message translates to:
  /// **'Moyen'**
  String get settingsPasswordStrengthMedium;

  /// No description provided for @settingsPasswordStrengthStrong.
  ///
  /// In fr, this message translates to:
  /// **'Fort'**
  String get settingsPasswordStrengthStrong;

  /// No description provided for @settingsPasswordStrengthVeryStrong.
  ///
  /// In fr, this message translates to:
  /// **'Très fort'**
  String get settingsPasswordStrengthVeryStrong;

  /// No description provided for @settingsPhoneNumber.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone'**
  String get settingsPhoneNumber;

  /// No description provided for @settingsValidate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get settingsValidate;

  /// No description provided for @settingsEditedAccount.
  ///
  /// In fr, this message translates to:
  /// **'Compte modifié avec succès'**
  String get settingsEditedAccount;

  /// No description provided for @settingsFailedToEditAccount.
  ///
  /// In fr, this message translates to:
  /// **'Échec de la modification du compte'**
  String get settingsFailedToEditAccount;

  /// No description provided for @settingsChooseLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Choix de la langue'**
  String get settingsChooseLanguage;

  /// Affiche le nombre de notifications actives sur le total des notifications disponibles, avec gestion du pluriel
  ///
  /// In fr, this message translates to:
  /// **'{active}/{total} {active, plural, zero {activée} one {activée} other {activées}}'**
  String settingsNotificationCounter(int active, int total);

  /// No description provided for @settingsEvent.
  ///
  /// In fr, this message translates to:
  /// **'Événement'**
  String get settingsEvent;

  /// No description provided for @settingsIcal.
  ///
  /// In fr, this message translates to:
  /// **'Lien Ical'**
  String get settingsIcal;

  /// No description provided for @settingsSynncWithCalendar.
  ///
  /// In fr, this message translates to:
  /// **'Synchroniser avec votre calendrier'**
  String get settingsSynncWithCalendar;

  /// No description provided for @settingsIcalLinkCopied.
  ///
  /// In fr, this message translates to:
  /// **'Lien Ical copié dans le presse-papier'**
  String get settingsIcalLinkCopied;

  /// No description provided for @settingsProfile.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get settingsProfile;

  /// No description provided for @settingsConnexion.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get settingsConnexion;

  /// No description provided for @settingsLogOut.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get settingsLogOut;

  /// No description provided for @settingsLogOutDescription.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir vous déconnecter ?'**
  String get settingsLogOutDescription;

  /// No description provided for @settingsLogOutSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion réussie'**
  String get settingsLogOutSuccess;

  /// No description provided for @settingsDeleteMyAccount.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer mon compte'**
  String get settingsDeleteMyAccount;

  /// No description provided for @settingsDeleteMyAccountDescription.
  ///
  /// In fr, this message translates to:
  /// **'Cette action notifie l\'administrateur que vous souhaitez supprimer votre compte.'**
  String get settingsDeleteMyAccountDescription;

  /// No description provided for @settingsDeletionAsked.
  ///
  /// In fr, this message translates to:
  /// **'Demande de suppression de compte envoyée'**
  String get settingsDeletionAsked;

  /// No description provided for @settingsDeleteMyAccountError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la demande de suppression de compte'**
  String get settingsDeleteMyAccountError;

  /// No description provided for @voteAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get voteAdd;

  /// No description provided for @voteAddMember.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un membre'**
  String get voteAddMember;

  /// No description provided for @voteAddedPretendance.
  ///
  /// In fr, this message translates to:
  /// **'Liste ajoutée'**
  String get voteAddedPretendance;

  /// No description provided for @voteAddedSection.
  ///
  /// In fr, this message translates to:
  /// **'Section ajoutée'**
  String get voteAddedSection;

  /// No description provided for @voteAddingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ajout'**
  String get voteAddingError;

  /// No description provided for @voteAddPretendance.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une liste'**
  String get voteAddPretendance;

  /// No description provided for @voteAddSection.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une section'**
  String get voteAddSection;

  /// No description provided for @voteAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get voteAll;

  /// No description provided for @voteAlreadyAddedMember.
  ///
  /// In fr, this message translates to:
  /// **'Membre déjà ajouté'**
  String get voteAlreadyAddedMember;

  /// No description provided for @voteAlreadyVoted.
  ///
  /// In fr, this message translates to:
  /// **'Vote enregistré'**
  String get voteAlreadyVoted;

  /// No description provided for @voteChooseList.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une liste'**
  String get voteChooseList;

  /// No description provided for @voteClear.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser'**
  String get voteClear;

  /// No description provided for @voteClearVotes.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser les votes'**
  String get voteClearVotes;

  /// No description provided for @voteClosedVote.
  ///
  /// In fr, this message translates to:
  /// **'Votes clos'**
  String get voteClosedVote;

  /// No description provided for @voteCloseVote.
  ///
  /// In fr, this message translates to:
  /// **'Fermer les votes'**
  String get voteCloseVote;

  /// No description provided for @voteConfirmVote.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le vote'**
  String get voteConfirmVote;

  /// No description provided for @voteCountVote.
  ///
  /// In fr, this message translates to:
  /// **'Dépouiller les votes'**
  String get voteCountVote;

  /// No description provided for @voteDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get voteDelete;

  /// No description provided for @voteDeletedAll.
  ///
  /// In fr, this message translates to:
  /// **'Tout supprimé'**
  String get voteDeletedAll;

  /// No description provided for @voteDeletedPipo.
  ///
  /// In fr, this message translates to:
  /// **'Listes pipos supprimées'**
  String get voteDeletedPipo;

  /// No description provided for @voteDeletedSection.
  ///
  /// In fr, this message translates to:
  /// **'Section supprimée'**
  String get voteDeletedSection;

  /// No description provided for @voteDeleteAll.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer tout'**
  String get voteDeleteAll;

  /// No description provided for @voteDeleteAllDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer tout ?'**
  String get voteDeleteAllDescription;

  /// No description provided for @voteDeletePipo.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer les listes pipos'**
  String get voteDeletePipo;

  /// No description provided for @voteDeletePipoDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer les listes pipos ?'**
  String get voteDeletePipoDescription;

  /// No description provided for @voteDeletePretendance.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la liste'**
  String get voteDeletePretendance;

  /// No description provided for @voteDeletePretendanceDesc.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer cette liste ?'**
  String get voteDeletePretendanceDesc;

  /// No description provided for @voteDeleteSection.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la section'**
  String get voteDeleteSection;

  /// No description provided for @voteDeleteSectionDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer cette section ?'**
  String get voteDeleteSectionDescription;

  /// No description provided for @voteDeletingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get voteDeletingError;

  /// No description provided for @voteDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get voteDescription;

  /// No description provided for @voteEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get voteEdit;

  /// No description provided for @voteEditedPretendance.
  ///
  /// In fr, this message translates to:
  /// **'Liste modifiée'**
  String get voteEditedPretendance;

  /// No description provided for @voteEditedSection.
  ///
  /// In fr, this message translates to:
  /// **'Section modifiée'**
  String get voteEditedSection;

  /// No description provided for @voteEditingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la modification'**
  String get voteEditingError;

  /// No description provided for @voteErrorClosingVotes.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la fermeture des votes'**
  String get voteErrorClosingVotes;

  /// No description provided for @voteErrorCountingVotes.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du dépouillement des votes'**
  String get voteErrorCountingVotes;

  /// No description provided for @voteErrorResetingVotes.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la réinitialisation des votes'**
  String get voteErrorResetingVotes;

  /// No description provided for @voteErrorOpeningVotes.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'ouverture des votes'**
  String get voteErrorOpeningVotes;

  /// No description provided for @voteIncorrectOrMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Champs incorrects ou manquants'**
  String get voteIncorrectOrMissingFields;

  /// No description provided for @voteMembers.
  ///
  /// In fr, this message translates to:
  /// **'Membres'**
  String get voteMembers;

  /// No description provided for @voteName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get voteName;

  /// No description provided for @voteNoPretendanceList.
  ///
  /// In fr, this message translates to:
  /// **'Aucune liste de prétendance'**
  String get voteNoPretendanceList;

  /// No description provided for @voteNoSection.
  ///
  /// In fr, this message translates to:
  /// **'Aucune section'**
  String get voteNoSection;

  /// No description provided for @voteCanNotVote.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne pouvez pas voter'**
  String get voteCanNotVote;

  /// No description provided for @voteNoSectionList.
  ///
  /// In fr, this message translates to:
  /// **'Aucune section'**
  String get voteNoSectionList;

  /// No description provided for @voteNotOpenedVote.
  ///
  /// In fr, this message translates to:
  /// **'Vote non ouvert'**
  String get voteNotOpenedVote;

  /// No description provided for @voteOnGoingCount.
  ///
  /// In fr, this message translates to:
  /// **'Dépouillement en cours'**
  String get voteOnGoingCount;

  /// No description provided for @voteOpenVote.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir les votes'**
  String get voteOpenVote;

  /// No description provided for @votePipo.
  ///
  /// In fr, this message translates to:
  /// **'Pipo'**
  String get votePipo;

  /// No description provided for @votePretendance.
  ///
  /// In fr, this message translates to:
  /// **'Listes'**
  String get votePretendance;

  /// No description provided for @votePretendanceDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Prétendance supprimée'**
  String get votePretendanceDeleted;

  /// No description provided for @votePretendanceNotDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get votePretendanceNotDeleted;

  /// No description provided for @voteProgram.
  ///
  /// In fr, this message translates to:
  /// **'Programme'**
  String get voteProgram;

  /// No description provided for @votePublish.
  ///
  /// In fr, this message translates to:
  /// **'Publier'**
  String get votePublish;

  /// No description provided for @votePublishVoteDescription.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment publier les votes ?'**
  String get votePublishVoteDescription;

  /// No description provided for @voteResetedVotes.
  ///
  /// In fr, this message translates to:
  /// **'Votes réinitialisés'**
  String get voteResetedVotes;

  /// No description provided for @voteResetVote.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser les votes'**
  String get voteResetVote;

  /// No description provided for @voteResetVoteDescription.
  ///
  /// In fr, this message translates to:
  /// **'Que voulez-vous faire ?'**
  String get voteResetVoteDescription;

  /// No description provided for @voteRole.
  ///
  /// In fr, this message translates to:
  /// **'Rôle'**
  String get voteRole;

  /// No description provided for @voteSectionDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description de la section'**
  String get voteSectionDescription;

  /// No description provided for @voteSection.
  ///
  /// In fr, this message translates to:
  /// **'Section'**
  String get voteSection;

  /// No description provided for @voteSectionName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la section'**
  String get voteSectionName;

  /// No description provided for @voteSeeMore.
  ///
  /// In fr, this message translates to:
  /// **'Voir plus'**
  String get voteSeeMore;

  /// No description provided for @voteSelected.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionné'**
  String get voteSelected;

  /// No description provided for @voteShowVotes.
  ///
  /// In fr, this message translates to:
  /// **'Voir les votes'**
  String get voteShowVotes;

  /// No description provided for @voteVote.
  ///
  /// In fr, this message translates to:
  /// **'Vote'**
  String get voteVote;

  /// No description provided for @voteVoteError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'enregistrement du vote'**
  String get voteVoteError;

  /// No description provided for @voteVoteFor.
  ///
  /// In fr, this message translates to:
  /// **'Voter pour '**
  String get voteVoteFor;

  /// No description provided for @voteVoteNotStarted.
  ///
  /// In fr, this message translates to:
  /// **'Vote non ouvert'**
  String get voteVoteNotStarted;

  /// No description provided for @voteVoters.
  ///
  /// In fr, this message translates to:
  /// **'Groupes votants'**
  String get voteVoters;

  /// No description provided for @voteVoteSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Vote enregistré'**
  String get voteVoteSuccess;

  /// No description provided for @voteVotes.
  ///
  /// In fr, this message translates to:
  /// **'Voix'**
  String get voteVotes;

  /// No description provided for @voteVotesClosed.
  ///
  /// In fr, this message translates to:
  /// **'Votes clos'**
  String get voteVotesClosed;

  /// No description provided for @voteVotesCounted.
  ///
  /// In fr, this message translates to:
  /// **'Votes dépouillés'**
  String get voteVotesCounted;

  /// No description provided for @voteVotesOpened.
  ///
  /// In fr, this message translates to:
  /// **'Votes ouverts'**
  String get voteVotesOpened;

  /// No description provided for @voteWarning.
  ///
  /// In fr, this message translates to:
  /// **'Attention'**
  String get voteWarning;

  /// No description provided for @voteWarningMessage.
  ///
  /// In fr, this message translates to:
  /// **'La sélection ne sera pas sauvegardée.\nVoulez-vous continuer ?'**
  String get voteWarningMessage;

  /// No description provided for @moduleAdvert.
  ///
  /// In fr, this message translates to:
  /// **'Annonces'**
  String get moduleAdvert;

  /// No description provided for @moduleAdvertDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les annonces'**
  String get moduleAdvertDescription;

  /// No description provided for @moduleAmap.
  ///
  /// In fr, this message translates to:
  /// **'AMAP'**
  String get moduleAmap;

  /// No description provided for @moduleAmapDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les livraisons et les produits'**
  String get moduleAmapDescription;

  /// No description provided for @moduleBooking.
  ///
  /// In fr, this message translates to:
  /// **'Réservation'**
  String get moduleBooking;

  /// No description provided for @moduleBookingDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les réservations, les salles et les managers'**
  String get moduleBookingDescription;

  /// No description provided for @moduleCalendar.
  ///
  /// In fr, this message translates to:
  /// **'Calendrier'**
  String get moduleCalendar;

  /// No description provided for @moduleCalendarDescription.
  ///
  /// In fr, this message translates to:
  /// **'Consulter les événements et les activités'**
  String get moduleCalendarDescription;

  /// No description provided for @moduleCentralisation.
  ///
  /// In fr, this message translates to:
  /// **'Centralisation'**
  String get moduleCentralisation;

  /// No description provided for @moduleCentralisationDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer la centralisation des données'**
  String get moduleCentralisationDescription;

  /// No description provided for @moduleCinema.
  ///
  /// In fr, this message translates to:
  /// **'Cinéma'**
  String get moduleCinema;

  /// No description provided for @moduleCinemaDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les séances de cinéma'**
  String get moduleCinemaDescription;

  /// No description provided for @moduleEvent.
  ///
  /// In fr, this message translates to:
  /// **'Événement'**
  String get moduleEvent;

  /// No description provided for @moduleEventDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les événements et les participants'**
  String get moduleEventDescription;

  /// No description provided for @moduleFlappyBird.
  ///
  /// In fr, this message translates to:
  /// **'Flappy Bird'**
  String get moduleFlappyBird;

  /// No description provided for @moduleFlappyBirdDescription.
  ///
  /// In fr, this message translates to:
  /// **'Jouer à Flappy Bird et consulter le classement'**
  String get moduleFlappyBirdDescription;

  /// No description provided for @moduleLoan.
  ///
  /// In fr, this message translates to:
  /// **'Prêt'**
  String get moduleLoan;

  /// No description provided for @moduleLoanDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les prêts et les articles'**
  String get moduleLoanDescription;

  /// No description provided for @modulePhonebook.
  ///
  /// In fr, this message translates to:
  /// **'Annuaire'**
  String get modulePhonebook;

  /// No description provided for @modulePhonebookDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les associations, les membres et les administrateurs'**
  String get modulePhonebookDescription;

  /// No description provided for @modulePurchases.
  ///
  /// In fr, this message translates to:
  /// **'Achats'**
  String get modulePurchases;

  /// No description provided for @modulePurchasesDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les achats, les tickets et l\'historique'**
  String get modulePurchasesDescription;

  /// No description provided for @moduleRaffle.
  ///
  /// In fr, this message translates to:
  /// **'Tombola'**
  String get moduleRaffle;

  /// No description provided for @moduleRaffleDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les tombolas, les prix et les tickets'**
  String get moduleRaffleDescription;

  /// No description provided for @moduleRecommendation.
  ///
  /// In fr, this message translates to:
  /// **'Bons plans'**
  String get moduleRecommendation;

  /// No description provided for @moduleRecommendationDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les recommandations, les informations et les administrateurs'**
  String get moduleRecommendationDescription;

  /// No description provided for @moduleSeedLibrary.
  ///
  /// In fr, this message translates to:
  /// **'Grainothèque'**
  String get moduleSeedLibrary;

  /// No description provided for @moduleSeedLibraryDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les graines, les espèces et les stocks'**
  String get moduleSeedLibraryDescription;

  /// No description provided for @moduleVote.
  ///
  /// In fr, this message translates to:
  /// **'Vote'**
  String get moduleVote;

  /// No description provided for @moduleVoteDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les votes, les sections et les candidats'**
  String get moduleVoteDescription;

  /// No description provided for @modulePh.
  ///
  /// In fr, this message translates to:
  /// **'PH'**
  String get modulePh;

  /// No description provided for @modulePhDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les PH, les formulaires et les administrateurs'**
  String get modulePhDescription;

  /// No description provided for @moduleSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get moduleSettings;

  /// No description provided for @moduleSettingsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les paramètres de l\'application'**
  String get moduleSettingsDescription;

  /// No description provided for @moduleFeed.
  ///
  /// In fr, this message translates to:
  /// **'Feed'**
  String get moduleFeed;

  /// No description provided for @moduleFeedDescription.
  ///
  /// In fr, this message translates to:
  /// **'Consulter les actualités et mises à jour'**
  String get moduleFeedDescription;

  /// No description provided for @moduleStyleGuide.
  ///
  /// In fr, this message translates to:
  /// **'StyleGuide'**
  String get moduleStyleGuide;

  /// No description provided for @moduleStyleGuideDescription.
  ///
  /// In fr, this message translates to:
  /// **'Explore the UI components and styles used in Titan'**
  String get moduleStyleGuideDescription;

  /// No description provided for @moduleAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Admin'**
  String get moduleAdmin;

  /// No description provided for @moduleAdminDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les utilisateurs, groupes et structures'**
  String get moduleAdminDescription;

  /// No description provided for @moduleOthers.
  ///
  /// In fr, this message translates to:
  /// **'Autres'**
  String get moduleOthers;

  /// No description provided for @moduleOthersDescription.
  ///
  /// In fr, this message translates to:
  /// **'Afficher les autres modules'**
  String get moduleOthersDescription;

  /// No description provided for @modulePayment.
  ///
  /// In fr, this message translates to:
  /// **'Paiement'**
  String get modulePayment;

  /// No description provided for @modulePaymentDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les paiements, les statistiques et les appareils'**
  String get modulePaymentDescription;

  /// No description provided for @toolInvalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Chiffre invalide'**
  String get toolInvalidNumber;

  /// No description provided for @toolDateRequired.
  ///
  /// In fr, this message translates to:
  /// **'Date requise'**
  String get toolDateRequired;

  /// No description provided for @toolSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Succès'**
  String get toolSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
