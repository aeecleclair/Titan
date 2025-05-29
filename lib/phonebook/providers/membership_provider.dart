import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/membership.dart';

final membershipProvider =
    StateNotifierProvider<MembershipProvider, Membership>((ref) {
      return MembershipProvider();
    });

class MembershipProvider extends StateNotifier<Membership> {
  MembershipProvider() : super(Membership.empty());

  void setMembership(Membership i) {
    state = i;
  }
}
