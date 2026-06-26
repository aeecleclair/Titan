import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class UserAssociationMembershipNotifier
    extends Notifier<UserMembershipComplete> {
  @override
  UserMembershipComplete build() {
    return UserMembershipComplete.empty();
  }

  void setUserAssociationMembership(
    UserMembershipComplete userUserAssociationMembership,
  ) {
    state = userUserAssociationMembership;
  }
}

final userAssociationMembershipProvider =
    NotifierProvider<UserAssociationMembershipNotifier, UserMembershipComplete>(
      UserAssociationMembershipNotifier.new,
    );
