import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/research_filter_provider.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:diacritic/diacritic.dart';

final associationFilteredListProvider = Provider<List<Association>>((ref) {
  final associationsProvider = ref.watch(associationListProvider);
  final associationGroupements = ref.watch(associationGroupementListProvider);
  final associationGroupement = ref.watch(associationGroupementProvider);
  final searchFilter = ref.watch(filterProvider);
  return associationsProvider.maybeWhen(
    data: (associations) {
      List<Association> filteredAssociations = associations
          .where(
            (association) => removeDiacritics(
              association.name.toLowerCase(),
            ).contains(removeDiacritics(searchFilter.toLowerCase())),
          )
          .toList();
      if (associationGroupement.id != "") {
        filteredAssociations = filteredAssociations
            .where(
              (association) =>
                  association.groupementId == associationGroupement.id,
            )
            .toList();
      }
      return associationGroupements.maybeWhen(
        data: (groupements) =>
            sortedAssociationByKind(filteredAssociations, groupements),
        orElse: () => filteredAssociations,
      );
    },
    orElse: () => [],
  );
});
