enum SortingType { newest, bestOfTheMonth }

String sortingTypeToString(SortingType t) {
  if (t == SortingType.newest) {
    return "Récent";
  }
  return "Meilleur du mois";
}
