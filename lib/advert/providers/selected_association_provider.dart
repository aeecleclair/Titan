import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';

final selectedAssociationProvider =
    StateNotifierProvider<AssociationNotifier, List<Association>>((ref) {
      return AssociationNotifier();
    });

class AssociationNotifier extends StateNotifier<List<Association>> {
  AssociationNotifier() : super([]);

  void addAssociation(Association i) {
    state.add(i);
    state = state.sublist(0);
  }

  void removeAssociation(Association i) {
    state = state.where((element) => element.id != i.id).toList();
  }

  void clearAssociation() {
    state = [];
  }
}
