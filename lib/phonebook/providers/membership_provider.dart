import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class MembershipProvider extends StateNotifier<MembershipComplete> {
  MembershipProvider() : super(EmptyModels.empty<MembershipComplete>());

  void setMembership(MembershipComplete i) {
    state = i;
  }
}

final membershipProvider =
    StateNotifierProvider<MembershipProvider, MembershipComplete>((ref) {
  return MembershipProvider();
});
