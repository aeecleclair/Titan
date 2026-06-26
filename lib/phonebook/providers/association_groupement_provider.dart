import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

final associationGroupementProvider =
    NotifierProvider<AssociationGroupementNotifier, AssociationGroupement>(
      () => AssociationGroupementNotifier(),
    );

class AssociationGroupementNotifier extends Notifier<AssociationGroupement> {
  @override
  AssociationGroupement build() {
    return AssociationGroupement.empty();
  }

  void setAssociationGroupement(AssociationGroupement i) {
    state = i;
  }

  void resetAssociationGroupement() {
    state = AssociationGroupement.empty();
  }
}
