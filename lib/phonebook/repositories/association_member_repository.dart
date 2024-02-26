import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationMemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

  Future<List<CompleteMember>> getAssociationMemberList(String associationId) async {
    return fakeMembersList.where((element) => element.memberships.map((e) => e.association.id).contains(associationId)).toList();
    //return List<CompleteMember>.from(
    //    (await getList(suffix: "$associationId/members")).map((x) => CompleteMember.fromJSON(x)));
  }
}