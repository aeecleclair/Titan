import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/tools/repository/repository.dart';

class MemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/member/";

  MemberRepository(super.ref);

  Future<CompleteMember> getCompleteMember(String memberId) async {
    return CompleteMember.fromJson(await getOne(memberId));
  }
}
