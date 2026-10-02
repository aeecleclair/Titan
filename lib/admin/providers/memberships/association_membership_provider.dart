import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/association_membership_simple.dart';

class AssociationMembershipNotifier
    extends StateNotifier<AssociationMembership> {
  AssociationMembershipNotifier() : super(AssociationMembership.empty());

  void setAssociationMembership(AssociationMembership associationMembership) {
    state = associationMembership;
  }
}

final associationMembershipProvider =
    StateNotifierProvider<AssociationMembershipNotifier, AssociationMembership>(
      (ref) => AssociationMembershipNotifier(),
    );
