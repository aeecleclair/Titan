import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/providers/filtered_association_list_provider.dart';


final filterProvider = StateNotifierProvider<FilterNotifier, String>((ref) {
  final filteredAssociationListNotifier = ref.watch(filteredAssociationListProvider.notifier);
  return FilterNotifier(filteredAssociationListNotifier);
});

class FilterNotifier extends StateNotifier<String> {
  FilterNotifier(this.filteredAssociationListNotifier
  ) : super("");

  late final FilteredAssociationListNotifier filteredAssociationListNotifier;

  void setFilter(String i) {
    state = i;
    filteredAssociationListNotifier.filterAssociationList(i);
  }
}