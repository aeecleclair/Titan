import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/association_membership_simple.dart';
import 'package:myecl/admin/class/user_association_membership.dart';
import 'package:myecl/admin/class/user_association_membership_base.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:intl/intl.dart';

class AssociationMembershipRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "memberships/";

  Future<List<AssociationMembership>> getAssociationMembershipList() async {
    return List<AssociationMembership>.from(
      (await getList()).map((x) => AssociationMembership.fromJson(x)),
    );
  }

  Future<List<UserAssociationMembership>> getAssociationMembershipMembers(
    String associationMembershipId,
  ) async {
    return List<UserAssociationMembership>.from(
      (await getList(suffix: "$associationMembershipId/members"))
          .map((x) => UserAssociationMembership.fromJson(x)),
    );
  }

  Future<bool> deleteAssociationMembership(
    String associationMembershipId,
  ) async {
    return await delete(associationMembershipId);
  }

  Future<bool> updateAssociationMembership(
    AssociationMembership associationMembership,
  ) async {
    return await update(
      associationMembership.toJson(),
      associationMembership.id,
    );
  }

  Future<AssociationMembership> createAssociationMembership(
    AssociationMembership associationMembership,
  ) async {
    return AssociationMembership.fromJson(
      await create(associationMembership.toJson()),
    );
  }

  Future<List<UserAssociationMembership>> getPersonalAssociationMembershipList([
    DateTime? minimalDate,
  ]) async {
    final DateFormat formatter = DateFormat('yyyyMMdd');
    return List<UserAssociationMembership>.from(
      (await getList(
        suffix:
            "users/me${minimalDate != null ? '?minimalDate=${formatter.format(minimalDate)}' : ''}",
      ))
          .map((x) => UserAssociationMembership.fromJson(x)),
    );
  }

  Future<List<UserAssociationMembership>> getUserAssociationMembershipList(
    String userId, [
    DateTime? minimalDate,
  ]) async {
    final DateFormat formatter = DateFormat('yyyyMMdd');
    return List<UserAssociationMembership>.from(
      (await getList(
        suffix:
            "users/$userId${minimalDate != null ? '?minimalDate=${formatter.format(minimalDate)}' : ''}",
      ))
          .map((x) => UserAssociationMembership.fromJson(x)),
    );
  }

  Future<UserAssociationMembership> addUserMembership(
    UserAssociationMembershipBase userAssociationMembership,
  ) async {
    return UserAssociationMembership.fromJson(
      await create(
        {
          "association_membership_id":
              userAssociationMembership.associationMembershipId,
          "start_date":
              processDateToAPIWithoutHour(userAssociationMembership.startDate),
          "end_date":
              processDateToAPIWithoutHour(userAssociationMembership.endDate),
        },
        suffix: "users/${userAssociationMembership.userId}",
      ),
    );
  }

  Future<bool> updateUserMembership(
    UserAssociationMembership userAssociationMembership,
  ) async {
    return await update(
      {
        "start_date":
            processDateToAPIWithoutHour(userAssociationMembership.startDate),
        "end_date":
            processDateToAPIWithoutHour(userAssociationMembership.endDate),
      },
      "",
      suffix: "users/${userAssociationMembership.id}",
    );
  }

  Future<bool> deleteUserMembership(
    String userAssociationMembershipId,
  ) async {
    return await delete(
      "",
      suffix: "users/$userAssociationMembershipId",
    );
  }
}

final associationMembershipRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return AssociationMembershipRepository()..setToken(token);
});
