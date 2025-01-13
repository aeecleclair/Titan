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
  static const String group = "Groupe";
  static const String groups = "Groupes";
  static const String delete = "Supprimer";
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
}

enum SchoolIdConstant {
  noSchool("dce19aa2-8863-4c93-861e-fb7be8f610ed"),
  eclSchool("d9772da7-1142-4002-8b86-b694b431dfed");

  const SchoolIdConstant(this.value);
  final String value;
}
