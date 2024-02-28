import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';

final associationFilteredListProvider = Provider<List<Association>>((ref) {
  final associationsProvider = ref.watch(associationListProvider);
  final kindFilter = ref.watch(associationKindProvider);
  final searchFilter = ref.watch(filterProvider);
  return associationsProvider.maybeWhen(
      data: (associations) {
        if (kindFilter == "") {
          return associations
              .where((element) => element.name
                  .toLowerCase()
                  .contains(searchFilter.toLowerCase()))
              .toList();
        } else {
          return associations
              .where((element) =>
                  element.name
                      .toLowerCase()
                      .contains(searchFilter.toLowerCase()) &&
                  element.kind == kindFilter)
              .toList();
        }
      },
      orElse: () => []);
});
