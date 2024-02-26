import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';


final associationProvider = StateNotifierProvider<AssociationProvider, Association>((ref) {
  return AssociationProvider();
});

class AssociationProvider extends StateNotifier<Association> {
AssociationProvider() : super(Association.empty());

  void setAssociation(Association i) {
    state = i;
  }
}