import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class AssociationNotifier extends Notifier<List<Association>> {
  @override
  List<Association> build() {
    return [];
  }

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

final selectedAssociationProvider =
    NotifierProvider<AssociationNotifier, List<Association>>(
      AssociationNotifier.new,
    );
