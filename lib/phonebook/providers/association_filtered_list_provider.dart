import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/providers/association_kinds_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/research_filter_provider.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:diacritic/diacritic.dart';

final associationFilteredListProvider = Provider<List<Association>>((ref) {
  final associationsProvider = ref.watch(associationListProvider);
  final associationKinds = ref.watch(associationKindsProvider);
  final kindFilter = ref.watch(associationKindProvider);
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
      if (kindFilter != "") {
        filteredAssociations = filteredAssociations
            .where((association) => association.kind == kindFilter)
            .toList();
      }
      return associationKinds.maybeWhen(
        data: (kinds) => sortedAssociationByKind(filteredAssociations, kinds),
        orElse: () => filteredAssociations,
      );
    },
    orElse: () => [],
  );
});
