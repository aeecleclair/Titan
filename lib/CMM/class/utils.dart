enum SortingType { newest, bestOfTheMonth }

String sortingTypeToString(SortingType t) {
  if (t == SortingType.newest) {
    return "Récent";
  }
  return "Meilleur du mois";
}

enum Period { week, month, year, always }

String periodToString(Period p) {
  if (p == Period.week) {
    return "Semaine";
  } else if (p == Period.month) {
    return "Mois";
  } else if (p == Period.year) {
    return "Année";
  }
  return "All time";
}

String periodToRequest(Period p) {
  if (p == Period.week) {
    return "week";
  } else if (p == Period.month) {
    return "month";
  } else if (p == Period.year) {
    return "year";
  }
  return "always";
}

enum Entity { user, floor, promo }

String entityToString(Entity e) {
  if (e == Entity.promo) {
    return "Promotion";
  } else if (e == Entity.floor) {
    return "Étage";
  }
  return "Utilisateur";
}

String entityToRequest(Entity e) {
  if (e == Entity.promo) {
    return "promo";
  } else if (e == Entity.floor) {
    return "floor";
  }
  return "user";
}

enum PageType { scrolling, myPost, hidden }
