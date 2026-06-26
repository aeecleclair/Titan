import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

//  Rework for stateNotifier
class AssociationNotifier extends Notifier<AssociationComplete> {
  @override
  AssociationComplete build() {
    return AssociationComplete.empty();
  }

  void setAssociation(AssociationComplete association) {
    state = association;
  }

  void resetAssociation() {
    state = AssociationComplete.empty();
  }
}

final associationProvider =
    NotifierProvider<AssociationNotifier, AssociationComplete>(() {
      return AssociationNotifier();
    });
