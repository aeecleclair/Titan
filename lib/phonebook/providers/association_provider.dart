import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';

class AssociationNotifier extends Notifier<Association> {
  @override
  Association build() {
    return Association.empty();
  }

  void setAssociation(Association association) {
    state = association;
  }
}

final associationProvider = NotifierProvider<AssociationNotifier, Association>(
  () {
    return AssociationNotifier();
  },
);
