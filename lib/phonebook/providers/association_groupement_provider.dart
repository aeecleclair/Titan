import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/association_groupement.dart';

final associationGroupementProvider =
    StateNotifierProvider<AssociationGroupementNotifier, AssociationGroupement>(
      (ref) {
        return AssociationGroupementNotifier();
      },
    );

class AssociationGroupementNotifier
    extends StateNotifier<AssociationGroupement> {
  AssociationGroupementNotifier() : super(AssociationGroupement.empty());

  void setAssociationGroupement(AssociationGroupement i) {
    state = i;
  }

  void resetAssociationGroupement() {
    state = AssociationGroupement.empty();
  }
}
