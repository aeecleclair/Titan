import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

final membershipProvider =
    NotifierProvider<MembershipProvider, MembershipComplete>(
      () => MembershipProvider(),
    );

class MembershipProvider extends Notifier<MembershipComplete> {
  @override
  MembershipComplete build() {
    return MembershipComplete.empty();
  }

  void setMembership(MembershipComplete i) {
    state = i;
  }
}
