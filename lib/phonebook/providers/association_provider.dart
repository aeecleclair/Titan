import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

//  Rework for stateNotifier
class AssociationNotifier extends Notifier<AssociationComplete> {
  @override
  AssociationComplete build() {
    return EmptyModels.empty<AssociationComplete>();
  }

  void setAssociation(AssociationComplete association) {
    state = association;
  }
}

final associationProvider =
    NotifierProvider<AssociationNotifier, AssociationComplete>(() {
  return AssociationNotifier();
});
