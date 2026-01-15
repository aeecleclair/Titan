class AdminTextConstants {
  static const String accountTypes = "Types de compte";
  static const String add = "Ajouter";
  static const String addGroup = "Ajouter un groupe";
  static const String addMember = "Ajouter un membre";
  static const String addedGroup = "Groupe créé";
  static const String addedLoaner = "Préteur ajouté";
  static const String addedMember = "Membre ajouté";
  static const String addingError = "Erreur lors de l'ajout";
  static const String addingMember = "Ajout d'un membre";
  static const String addLoaningGroup = "Ajouter un groupe de prêt";
  static const String addSchool = "Ajouter une école";
  static const String addStructure = "Ajouter une structure";
  static const String addedSchool = "École créée";
  static const String addedStructure = "Structure ajoutée";
  static const String editedStructure = "Structure modifiée";
  static const String administration = "Administration";
  static const String associationMembership = "Adhésion";
  static const String associationMembershipName = "Nom de l'adhésion";
  static const String associationsMemberships = "Adhésions";
  static const String clearFilters = "Effacer les filtres";
  static const String createAssociationMembership = "Créer une adhésion";
  static const String createdAssociationMembership = "Adhésion créée";
  static const String creationError = "Erreur lors de la création";
  static const String dateError =
      "La date de début doit être avant la date de fin";
  static const String delete = "Supprimer";
  static const String deleteAssociationMembership = "Supprimer l'adhésion ?";
  static const String deletedAssociationMembership = "Adhésion supprimée";
  static const String deleteGroup = "Supprimer le groupe ?";
  static const String deletedGroup = "Groupe supprimé";
  static const String deleteSchool = "Supprimer l'école ?";
  static const String deletedSchool = "École supprimée";
  static const String deleting = "Suppression";
  static const String deletingError = "Erreur lors de la suppression";
  static const String description = "Description";
  static const String eclSchool = "Centrale Lyon";
  static const String edit = "Modifier";
  static const String editStructure = "Modifier la structure";
  static const String editMembership = "Modifier l'adhésion";
  static const String emptyDate = "Date vide";
  static const String emptyFieldError = "Le nom ne peut pas être vide";
  static const String emailRegex = "Email Regex";
  static const String emptyUser = "Utilisateur vide";
  static const String endDate = "Date de fin";
  static const String endDateMaximal = "Date de fin maximale";
  static const String endDateMinimal = "Date de fin minimale";
  static const String error = "Erreur";
  static const String filters = "Filtres";
  static const String group = "Groupe";
  static const String groups = "Groupes";
  static const String loaningGroup = "Groupe de prêt";
  static const String looking = "Recherche";
  static const String manager = "Administrateur de la structure";
  static const String maximum = "Maximum";
  static const String members = "Membres";
  static const String membershipAddingError =
      "Erreur lors de l'ajout (surement dû à une superposition de dates)";
  static const String memberships = "Adhésions";
  static const String membershipUpdatingError =
      "Erreur lors de la modification (surement dû à une superposition de dates)";
  static const String minimum = "Minimum";
  static const String modifyModuleVisibility = "Visibilité des modules";
  static const String myPayment = "MyECLPay";
  static const String name = "Nom";
  static const String noManager = "Aucun manager n'est sélectionné";
  static const String noMember = "Aucun membre";
  static const String noMoreLoaner = "Aucun prêteur n'est disponible";
  static const String noSchool = "Sans école";
  static const String permissions = "Permissions";
  static const String removeGroupMember = "Supprimer le membre du groupe ?";
  static const String research = "Recherche";
  static const String schools = "Écoles";
  static const String structures = "Structures";
  static const String startDate = "Date de début";
  static const String startDateMaximal = "Date de début maximale";
  static const String startDateMinimal = "Date de début minimale";
  static const String updatedAssociationMembership = "Adhésion modifiée";
  static const String updatedGroup = "Groupe modifié";
  static const String updatedMembership = "Adhésion modifiée";
  static const String updatingError = "Erreur lors de la modification";
  static const String user = "Utilisateur";
  static const String validateFilters = "Valider les filtres";
  static const String structureShortId = "Identifiant court";
  static const String shortIdError =
      "L'identifiant court doit faire 3 caractères";
  static const String siegeAddress = "Adresse du siège";
  static const String structureStreetAddress = "Numéro et rue";
  static const String structureCity = "Ville";
  static const String structureZipcode = "Code postal";
  static const String structureCountry = "Pays";
  static const String structureSiret = "Numéro SIRET";
  static const String structureSiretError = "Numéro SIRET invalide";
  static const String structureBankInformation = "Informations bancaires";
  static const String structureIban = "IBAN";
  static const String structureIbanError = "IBAN invalide";
  static const String structureBic = "BIC";
  static const String structureBicError = "BIC invalide";
  static const String structureManagerError =
      "Un manager doit être sélectionné";
  static const String updatedStructure = "Structure mise à jour avec succès";
  static const String updateStructureError =
      "Erreur lors de la mise à jour de la structure";
  static const String addStructureError =
      "Erreur lors de l'ajout de la structure";
  static const String noBankAccountHolder =
      "Aucun titulaire de compte bancaire";
  static const String currentBankAccountHolder =
      "Titulaire de compte bancaire actuel";
  static const String setAsBankAccountHolderSuccess =
      "Défini comme titulaire du compte bancaire avec succès";
  static const String setAsBankAccountHolderError =
      "Erreur lors de la définition comme titulaire du compte bancaire";
  static const String setAsBankAccountHolder =
      "Définir comme titulaire du compte bancaire";
  static const String deletingDescription =
      "Attention, cette action est irréversible";
  static const String deletedStructure = "Structure supprimée avec succès";
  static const String deletingStructureError =
      "Erreur lors de la suppression de la structure";
}

enum SchoolIdConstant {
  noSchool("dce19aa2-8863-4c93-861e-fb7be8f610ed"),
  eclSchool("d9772da7-1142-4002-8b86-b694b431dfed");

  const SchoolIdConstant(this.value);
  final String value;
}
