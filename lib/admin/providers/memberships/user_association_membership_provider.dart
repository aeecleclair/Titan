import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/user_association_membership.dart';

class UserAssociationMembershipNotifier
    extends StateNotifier<UserAssociationMembership> {
  UserAssociationMembershipNotifier()
    : super(UserAssociationMembership.empty());

  void setUserAssociationMembership(
    UserAssociationMembership userUserAssociationMembership,
  ) {
    state = userUserAssociationMembership;
  }
}

final userAssociationMembershipProvider =
    StateNotifierProvider<
      UserAssociationMembershipNotifier,
      UserAssociationMembership
    >((ref) => UserAssociationMembershipNotifier());
