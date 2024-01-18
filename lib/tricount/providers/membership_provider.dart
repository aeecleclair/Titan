import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group_membership.dart';

class SharerGroupMemberListProvider extends StateNotifier<SharerGroupMembership> {
  SharerGroupMemberListProvider() : super(SharerGroupMembership.empty());

  void set(SharerGroupMembership i) {
    state = i;
  }
}

final sharerGroupMembershipProvider =
    StateNotifierProvider<SharerGroupMemberListProvider, SharerGroupMembership>(
        (ref) {
  return SharerGroupMemberListProvider();
});
