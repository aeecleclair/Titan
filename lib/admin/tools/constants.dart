class AdminTextConstants {
  static const String accountTypes = "Types de compte";
  static const String add = "Ajouter";
  static const String addGroup = "Ajouter un groupe";
  static const String addedGroup = "Groupe créé";
  static const String addedLoaner = "Préteur ajouté";
  static const String addedMember = "Membre ajouté";
  static const String addingError = "Erreur lors de l'ajout";
  static const String addingMember = "Ajout d'un membre";
  static const String addLoaningGroup = "Ajouter un groupe de prêt";
  static const String addSchool = "Ajouter une école";
  static const String addedSchool = "École créée";
  static const String administration = "Administration";
  static const String associationsMemberships = "Adhésions d'associations";
  static const String group = "Groupe";
  static const String groups = "Groupes";
  static const String delete = "Supprimer";
  static const String deleteAssociationMembership =
      "Supprimer l'adhésion d'association ?";
  static const String deletedAssociationMembership =
      "Adhésion d'association supprimée";

  static const String deleteGroup = "Supprimer le groupe ?";
  static const String deletedGroup = "Groupe supprimé";
  static const String deleteSchool = "Supprimer l'école ?";
  static const String deletedSchool = "École supprimée";
  static const String deleting = "Suppression";
  static const String deletingError = "Erreur lors de la suppression";
  static const String description = "Description";
  static const String eclSchool = "Centrale Lyon";
  static const String edit = "Modifier";
  static const String emailRegex = "Email Regex";
  static const String emptyFieldError = "Le nom ne peut pas être vide";
  static const String error = "Erreur";
  static const String loaningGroup = "Groupe de prêt";
  static const String looking = "Recherche";
  static const String members = "Membres";
  static const String modifyModuleVisibility = "Visibilité des modules";
  static const String name = "Nom";
  static const String noMoreLoaner = "Aucun prêteur n'est disponible";
  static const String noSchool = "Sans école";
  static const String removeGroupMember = "Supprimer le membre du groupe ?";
  static const String schools = "Écoles";
  static const String updatedGroup = "Groupe modifié";
  static const String updatingError = "Erreur lors de la modification";
  static const String visibilities = "Visibilités";

  static const String updatedAssociationMembership =
      "Adhésion d'association modifiée";

  static const String noMember = "Aucun membre";

  static const String memberships = "Adhésions";

  static const String associationMembershipName = "Nom de l'adhésion";

  static const String createAssociationMembership =
      "Créer une adhésion d'association";

  static const String createdAssociationMembership =
      "Adhésion d'association créée";

  static const String creationError = "Erreur lors de la création";

  static const String associationMembership = "Adhésion de l'association";
}

enum SchoolIdConstant {
  noSchool("dce19aa2-8863-4c93-861e-fb7be8f610ed"),
  eclSchool("d9772da7-1142-4002-8b86-b694b431dfed");

  const SchoolIdConstant(this.value);
  final String value;
}
