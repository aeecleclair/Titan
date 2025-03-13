import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class AssociationNotifier extends StateNotifier<AssociationComplete> {
  AssociationNotifier() : super(EmptyModels.empty<AssociationComplete>());

  void setAssociation(AssociationComplete association) {
    state = association;
  }
}

final associationProvider =
    StateNotifierProvider<AssociationNotifier, AssociationComplete>((ref) {
  return AssociationNotifier();
});
