import 'package:flutter/material.dart';

class PhonebookTextConstants {
  static const String activeMandate = "Mandat actif :";
  static const String add = "Ajouter";
  static const String addAssociation = "Ajouter une association";
  static const String addedAssociation = "Association ajoutée";
  static const String addedMember = "Membre ajouté";
  static const String addingError = "Erreur lors de l'ajout";
  static const String addMember = "Ajouter un membre";
  static const String addRole = "Ajouter un rôle";
  static const String admin = "Admin";
  static const String adminPage = "Page Administrateur";
  static const String all = "Toutes";
  static const String apparentName = "Nom public du rôle :";
  static const String association = "Association :";
  static const String associationDetail = "Détail de l'association :";
  static const String associationKind = "Type d'association :";
  static const String associationPure = "Association";
  static const String associationPureSearch = "  Association";
  static const String associations = "Associations :";

  static const String cancel = "Annuler";
  static const String changeMandate = "Passer au mandat ";
  static const String changeMandateConfirm =
      "Êtes-vous sûr de vouloir changer tout le mandat ?\nCette action est irréversible !";
  static const String copied = "Copié dans le presse-papier";

  static const String deactivateAssociation =
      "Êtes-vous sûr de vouloir désactiver cette association ?\nCette action est irréversible !";
  static const String deactivatedAssociation = "Association désactivée";
  static const String deactivatedAssociationWarning =
      "Attention, cette association est désactivée, vous ne pouvez pas la modifier";
  static const String deactivating = "Désactiver l'association ?";
  static const String deactivatingError = "Erreur lors de la désactivation";
  static const String detail = "Détail :";
  static const String deleteAssociation =
      "Supprimer l'association ?\nCela va effacer tout l'historique de l'association";
  static const String deletedAssociation = "Association supprimée";
  static const String deletedMember = "Membre supprimé";
  static const String deleting = "Suppression";
  static const String deletingError = "Erreur lors de la suppression";
  static const String description = "Description";

  static const String edit = "Modifier";
  static const String editMembership = "Modifier le rôle";
  static const String email = "Email :";
  static const String emailCopied = "Email copié dans le presse-papier";
  static const String emptyApparentName = "Veuillez entrer un nom de role";
  static const String emptyFieldError = "Un champ n'est pas rempli";
  static const String emptyKindError = "Veuillez choisir un type d'association";
  static const String emptyMember = "Aucun membre sélectionné";
  static const String errorAssociationLoading =
      "Erreur lors du chargement de l'association";
  static const String errorAssociationNameEmpty =
      "Veuillez entrer un nom d'association";
  static const String errorAssociationPicture =
      "Erreur lors de la modification de la photo d'association";
  static const String errorKindsLoading =
      "Erreur lors du chargement des types d'association";
  static const String errorLoadAssociationList =
      "Erreur lors du chargement de la liste des associations";
  static const String errorLoadAssociationMember =
      "Erreur lors du chargement des membres de l'association";
  static const String errorLoadAssociationPicture =
      "Erreur lors du chargement de la photo d'association";
  static const String errorLoadProfilePicture = "Erreur";
  static const String errorRoleTagsLoading =
      "Erreur lors du chargement des tags de rôle";
  static const String existingMembership =
      "Ce membre est déjà dans le mandat actuel";

  static const String firstname = "Prénom :";

  static const String groups = "Groupes associés :";

  static const String mandateChangingError =
      "Erreur lors du changement de mandat";
  static const String member = "Membre";
  static const String memberReordered = "Membre réordonné";
  static const String members = "Membres";
  static const String membershipAssociationError =
      "Veuillez choisir une association";
  static const String membershipRole = "Rôle :";
  static const String membershipRoleError = "Veuillez choisir un rôle";

  static const String name = "Nom :";
  static const String nameCopied = "Nom et prénom copié dans le presse-papier";
  static const String namePure = "Nom";
  static const String newMandate = "Nouveau mandat";
  static const String newMandateConfirmed = "Mandat changé";
  static const String nickname = "Surnom :";
  static const String nicknameCopied = "Surnom copié dans le presse-papier";
  static const String noAssociationFound = "Aucune association trouvée";
  static const String noMember = "Aucun membre";
  static const String noMemberRole = "Aucun role trouvé";

  static const String phone = "Téléphone :";
  static const String phonebook = "Annuaire";
  static const String phonebookSearch = "Rechercher";
  static const String phonebookSearchAssociation = "Association";
  static const String phonebookSearchField = "Rechercher :";
  static const String phonebookSearchName = "Nom/Prénom/Surnom";
  static const String phonebookSearchRole = "Poste";
  static const String presidentRoleTag = "Prez'";
  static const String promoNotGiven = "Promo non renseignée";
  static const String promotion = "Promotion :";

  static const String reorderingError = "Erreur lors du réordonnement";
  static const String research = "Rechercher";
  static const String rolePure = "Rôle";

  static const String tooHeavyAssociationPicture =
      "L'image est trop lourde (max 4Mo)";

  static const String updateGroups = "Mettre à jour les groupes";
  static const String updatedAssociation = "Association modifiée";
  static const String updatedAssociationPicture =
      "La photo d'association a été changée";
  static const String updatedGroups = "Groupes mis à jour";
  static const String updatedMember = "Membre modifié";
  static const String updatingError = "Erreur lors de la modification";

  static const String validation = "Valider";
}

class PhonebookColorConstants {
  static const Color textDark = Color(0xFF1D1D1D);
}

class PhonebookPermissionConstants {
  static const String accessPhonebook = "access_phonebook";
  static const String managePhonebook = "manage_phonebook";
}
