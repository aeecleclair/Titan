import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/tools/repository/repository.dart';

class MemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/member/";

  Future<CompleteMember> getCompleteMember(String memberId) async {
    return CompleteMember.fromJson(await getOne(memberId));
  }
}
