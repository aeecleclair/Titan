import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class MembershipProvider extends StateNotifier<MembershipComplete> {
  MembershipProvider() : super(MembershipComplete.fromJson({}));

  void setMembership(MembershipComplete i) {
    state = i;
  }
}

final membershipProvider =
    StateNotifierProvider<MembershipProvider, MembershipComplete>((ref) {
  return MembershipProvider();
});
