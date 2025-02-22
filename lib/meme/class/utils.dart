import 'package:flutter/material.dart';

enum SortingType { best, worst, trending, newest, oldest }

String sortingTypeToString(SortingType t) {
  switch (t) {
    case SortingType.best:
      return MemeTextConstant.best;
    case SortingType.worst:
      return MemeTextConstant.worst;
    case SortingType.trending:
      return MemeTextConstant.trending;
    case SortingType.newest:
      return MemeTextConstant.newest;
    case SortingType.oldest:
      return MemeTextConstant.oldest;
  }
}

enum Period { week, month, year, always }

String periodToString(Period p) {
  if (p == Period.week) {
    return MemeTextConstant.week;
  } else if (p == Period.month) {
    return MemeTextConstant.month;
  } else if (p == Period.year) {
    return MemeTextConstant.year;
  }
  return MemeTextConstant.allTime;
}

enum Entity { user, floor, promo }

String entityToString(Entity e) {
  if (e == Entity.promo) {
    return MemeTextConstant.promo;
  } else if (e == Entity.floor) {
    return MemeTextConstant.floor;
  }
  return MemeTextConstant.user;
}

enum PageType { scrolling, myPost, hidden }

class MemeTextConstant {
  static const String hideMeme = "Cacher un meme";
  static const String wantToHideMeme = "Voulez-vous vraiment cacher ce meme ?";
  static const String hiddenMeme = "Meme caché";
  static const String errorHiddingMeme =
      "Erreur lors l'invisibilisation du meme";
  static const String banUser = "Bannir un utilisateur";
  static const String wantToBanUser =
      "Voulez-vous vraiment bannir cet utilisateur ?";
  static const String bannedUser = "Utilisateur banni";
  static const String errorBanningUser =
      "Erreur lors du bannissement de l'utilisateur";
  static const String deleteMeme = "Supprimer un meme";
  static const String wantToDeleteMeme =
      "Voulez-vous vraiment supprimer ce meme ?";
  static const String deletedMeme = "Meme supprimé";
  static const String errorDeletingMeme =
      "Erreur lors de la suppression du meme";
  static const String showMeme = "Rendre visible un meme";
  static const String wantToShowMeme =
      "Voulez-vous vraiment rendre visible ce meme ?";
  static const String showedMeme = "Meme rendu visible";
  static const String errorShowingMeme =
      "Erreur lors de la visibilisation du meme";
  static const String filters = "Filtres";
  static const String addThisMeme = "Ajouter ce meme";
  static const String addMeme = "Ajouter un meme";
  static const String choicePoster = "Choix du poster";
  static const String loading = "Loading";
  static const String cmm = "CMM";
  static const String best = "Meilleur";
  static const String worst = "Pire";
  static const String trending = "Tendance";
  static const String newest = "Récent";
  static const String oldest = "Ancien";
  static const String week = "Semaine";
  static const String month = "Mois";
  static const String year = "Année";
  static const String allTime = "All time";
  static const String user = "Utilisateur";
  static const String floor = "Étage";
  static const String promo = "Promotion";
}
