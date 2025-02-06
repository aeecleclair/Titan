import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/user_association_membership.dart';
import 'package:myecl/admin/class/user_association_membership_base.dart';
import 'package:myecl/admin/repositories/association_membership_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/class/simple_users.dart';

class AssociationMembershipMembersNotifier
    extends ListNotifier<UserAssociationMembership> {
  final AssociationMembershipRepository associationMembershipRepository;
  AssociationMembershipMembersNotifier({
    required this.associationMembershipRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<UserAssociationMembership>>>
      loadAssociationMembershipMembers(String associationMembershipId) async {
    return await loadList(
      () async => associationMembershipRepository
          .getAssociationMembershipMembers(associationMembershipId),
    );
  }

  Future<bool> addMember(
    UserAssociationMembershipBase userAssociationMembership,
    SimpleUser user,
  ) async {
    return await add(
      (associationMembership) async => associationMembershipRepository
          .addUserMembership(userAssociationMembership),
      UserAssociationMembership(
        id: userAssociationMembership.id,
        associationMembershipId:
            userAssociationMembership.associationMembershipId,
        userId: userAssociationMembership.userId,
        startDate: userAssociationMembership.startDate,
        endDate: userAssociationMembership.endDate,
        user: user,
      ),
    );
  }

  Future<bool> deleteMember(
    UserAssociationMembership associationMembership,
  ) async {
    return await delete(
      (membershipId) async =>
          associationMembershipRepository.deleteUserMembership(membershipId),
      (userAssociationMemberships, membership) =>
          userAssociationMemberships..remove(associationMembership),
      associationMembership.id,
      associationMembership,
    );
  }
}

final associationMembershipMembersProvider = StateNotifierProvider<
    AssociationMembershipMembersNotifier,
    AsyncValue<List<UserAssociationMembership>>>((ref) {
  final associationMembershipRepository =
      ref.watch(associationMembershipRepositoryProvider);
  return AssociationMembershipMembersNotifier(
    associationMembershipRepository: associationMembershipRepository,
  );
});
