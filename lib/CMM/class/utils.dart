enum SortingType { newest, bestOfTheMonth }

String sortingTypeToString(SortingType t) {
  if (t == SortingType.newest) {
    return "Récent";
  }
  return "Meilleur du mois";
}

enum Period { week, month, always }

String periodToString(Period p) {
  if (p == Period.week) {
    return "Semaine";
  } else if (p == Period.month) {
    return "Mois";
  }
  return "All time";
}

String periodToRequest(Period p) {
  if (p == Period.week) {
    return "week";
  } else if (p == Period.month) {
    return "month";
  }
  return "always";
}

enum EntityType { user, floor, promo }

String entityToString(EntityType t) {
  if (t == EntityType.promo) {
    return "Promotion";
  } else if (t == EntityType.floor) {
    return "Étage";
  }
  return "Utilisateur";
}

String entityToRequest(EntityType t) {
  if (t == EntityType.promo) {
    return "promotion";
  } else if (t == EntityType.floor) {
    return "floor";
  }
  return "user";
}
