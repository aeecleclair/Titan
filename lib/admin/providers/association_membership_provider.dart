import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class AssociationMembershipNotifier extends Notifier<MembershipSimple> {
  @override
  MembershipSimple build() {
    return MembershipSimple.empty();
  }

  void setAssociationMembership(MembershipSimple associationMembership) {
    state = associationMembership;
  }
}

final associationMembershipProvider =
    NotifierProvider<AssociationMembershipNotifier, MembershipSimple>(
      () => AssociationMembershipNotifier(),
    );
