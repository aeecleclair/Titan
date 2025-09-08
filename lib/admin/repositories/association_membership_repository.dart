import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

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
    String associationMembershipId, [
    DateTime? minimalStartDate,
    DateTime? minimalEndDate,
    DateTime? maximalStartDate,
    DateTime? maximalEndDate,
  ]) async {
    String querries = "";
    if (minimalStartDate != null) {
      querries +=
          "?minimalStartDate=${processDateToAPIWithoutHour(minimalStartDate)}";
    }
    if (minimalEndDate != null) {
      querries += querries.isEmpty ? "?" : "&";
      querries +=
          "minimalEndDate=${processDateToAPIWithoutHour(minimalEndDate)}";
    }
    if (maximalStartDate != null) {
      querries += querries.isEmpty ? "?" : "&";
      querries +=
          "maximalStartDate=${processDateToAPIWithoutHour(maximalStartDate)}";
    }
    if (maximalEndDate != null) {
      querries += querries.isEmpty ? "?" : "&";
      querries +=
          "maximalEndDate=${processDateToAPIWithoutHour(maximalEndDate)}";
    }
    return List<UserAssociationMembership>.from(
      (await getList(
        suffix: "$associationMembershipId/members$querries",
      )).map((x) => UserAssociationMembership.fromJson(x)),
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
}

final associationMembershipRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return AssociationMembershipRepository()..setToken(token);
});
