import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tricount/class/sharer_group_membership.dart';

class MembershipRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/";

  Future<List<SharerGroupMembership>> getMembershipList() async {
    return List<SharerGroupMembership>.from(
        (await getList(suffix: "memberships"))
            .map((x) => SharerGroupMembership.fromJson(x)));
  }

  Future<SharerGroupMembership> createMembership(
      SharerGroupMembership sharerGroup) async {
    return SharerGroupMembership.fromJson(
        await create(sharerGroup.toJson(), suffix: "memberships"));
  }

  Future<bool> deleteMembership(
      String sharerGroupId, String sharerMembershipId) async {
    return await delete("/$sharerMembershipId");
  }
}
