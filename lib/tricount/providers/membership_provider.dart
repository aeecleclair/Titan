import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tricount/class/sharer_group_membership.dart';
import 'package:myecl/tricount/repositories/membership_repository.dart';

class MembershipListNotifier extends ListNotifier<SharerGroupMembership> {
  final MembershipRepository membershipRepository = MembershipRepository();
  MembershipListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    membershipRepository.setToken(token);
  }

  Future<AsyncValue<List<SharerGroupMembership>>> loadMembership() async {
    return await loadList(membershipRepository.getMembershipList);
  }

  Future<bool> addMembership(SharerGroupMembership membership) async {
    return await add(membershipRepository.createMembership, membership);
  }

  Future<bool> deleteSharerFromSharerGroup(
      SharerGroupMembership membership, String sharerId) async {
    return await delete(
        (_) =>
            membershipRepository.deleteMembership(sharerId, membership.userId),
        (sharerGroups, membership) => sharerGroups
          ..removeWhere((i) =>
              i.userId == membership.userId &&
              i.sharerGroupId == membership.sharerGroupId),
        membership.sharerGroupId,
        membership);
  }
}

final membershipListProvider = StateNotifierProvider<MembershipListNotifier,
    AsyncValue<List<SharerGroupMembership>>>((ref) {
  final token = ref.watch(tokenProvider);
  final membershipListNotifier = MembershipListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    membershipListNotifier.loadMembership();
  });
  return membershipListNotifier;
});
