import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationMemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

  Future<List<CompleteMember>> getAssociationMemberList(
    String associationId,
    int year,
  ) async {
    return List<CompleteMember>.from(
      (await getList(
        suffix: "$associationId/members/$year",
      )).map((x) => CompleteMember.fromJson(x)),
    );
  }

  Future<Membership> addMember(Membership membership) async {
    return Membership.fromJson(
      await create(membership.toJson(), suffix: "memberships"),
    );
  }

  Future<bool> updateMember(Membership membership) async {
    return await update(
      membership.toJson(),
      "memberships/",
      suffix: membership.id,
    );
  }

  Future<bool> deleteMember(String membershipId) async {
    return await delete("memberships/$membershipId");
  }
}
