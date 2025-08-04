import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/user_association_membership.dart';
import 'package:titan/super_admin/class/user_association_membership_base.dart';
import 'package:titan/admin/repositories/association_membership_repository.dart';
import 'package:titan/super_admin/repositories/association_membership_user_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/user/class/simple_users.dart';

class AssociationMembershipMembersNotifier
    extends ListNotifier<UserAssociationMembership> {
  final AssociationMembershipRepository associationMembershipRepository;
  final AssociationMembershipUserRepository associationMembershipUserRepository;
  AssociationMembershipMembersNotifier({
    required this.associationMembershipRepository,
    required this.associationMembershipUserRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<UserAssociationMembership>>>
  loadAssociationMembershipMembers(
    String associationMembershipId, {
    DateTime? minimalStartDate,
    DateTime? minimalEndDate,
    DateTime? maximalStartDate,
    DateTime? maximalEndDate,
  }) async {
    return await loadList(
      () async =>
          associationMembershipRepository.getAssociationMembershipMembers(
            associationMembershipId,
            minimalStartDate,
            minimalEndDate,
            maximalStartDate,
            maximalEndDate,
          ),
    );
  }

  Future<bool> addMember(
    UserAssociationMembershipBase userAssociationMembership,
    SimpleUser user,
  ) async {
    return await add(
      (associationMembership) async => associationMembershipUserRepository
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

  Future<bool> updateMember(
    UserAssociationMembership associationMembership,
  ) async {
    return await update(
      (associationMembership) async => associationMembershipUserRepository
          .updateUserMembership(associationMembership),
      (userAssociationMemberships, membership) => userAssociationMemberships
        ..[userAssociationMemberships.indexWhere(
              (g) => g.id == membership.id,
            )] =
            membership,
      associationMembership,
    );
  }

  Future<bool> deleteMember(
    UserAssociationMembership associationMembership,
  ) async {
    return await delete(
      (membershipId) async => associationMembershipUserRepository
          .deleteUserMembership(membershipId),
      (userAssociationMemberships, membership) =>
          userAssociationMemberships..remove(associationMembership),
      associationMembership.id,
      associationMembership,
    );
  }
}

final associationMembershipMembersProvider =
    StateNotifierProvider<
      AssociationMembershipMembersNotifier,
      AsyncValue<List<UserAssociationMembership>>
    >((ref) {
      final associationMembershipUserRepository = ref.watch(
        associationMembershipUserRepositoryProvider,
      );
      final associationMembershipRepository = ref.watch(
        associationMembershipRepositoryProvider,
      );
      return AssociationMembershipMembersNotifier(
        associationMembershipRepository: associationMembershipRepository,
        associationMembershipUserRepository:
            associationMembershipUserRepository,
      );
    });
