import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/class/user_association_membership_base.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationMembershipUserRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "memberships/users/";

  Future<List<UserAssociationMembership>>
  getPersonalAssociationMembershipList() async {
    return List<UserAssociationMembership>.from(
      (await getList(
        suffix: "me",
      )).map((x) => UserAssociationMembership.fromJson(x)),
    );
  }

  Future<List<UserAssociationMembership>> getUserAssociationMembershipList(
    String userId,
  ) async {
    return List<UserAssociationMembership>.from(
      (await getList(
        suffix: userId,
      )).map((x) => UserAssociationMembership.fromJson(x)),
    );
  }

  Future<UserAssociationMembership> addUserMembership(
    UserAssociationMembershipBase userAssociationMembership,
  ) async {
    return UserAssociationMembership.fromJson(
      await create(
        userAssociationMembership.toJson(),
        suffix: userAssociationMembership.userId,
      ),
    );
  }

  Future<bool> updateUserMembership(
    UserAssociationMembership userAssociationMembership,
  ) async {
    return await update(
      userAssociationMembership.toJson(),
      userAssociationMembership.id,
    );
  }

  Future<bool> deleteUserMembership(String userAssociationMembershipId) async {
    return await delete(userAssociationMembershipId);
  }
}

final associationMembershipUserRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return AssociationMembershipUserRepository()..setToken(token);
});
