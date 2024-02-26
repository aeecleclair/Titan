import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationMemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/association/";

  Future<List<CompleteMember>> getAssociationMemberList(String associationId) async {
    return List<CompleteMember>.from(
        (await getList(suffix: "$associationId/members")).map((x) => CompleteMember.fromJSON(x)));
  }
}