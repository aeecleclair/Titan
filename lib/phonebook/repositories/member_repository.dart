import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/tools/repository/repository.dart';

class MemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/member/";

  Future<List<Membership>> getMemberMembershipList(int memberId) async {
    return List<Membership>.from((await getList(suffix: "/$memberId/posts"))
        .map((x) => Membership.fromJson(x)));
  }

  Future<Member> getMember(String memberId) async {
    return Member.fromJson(await getOne(memberId));
  }

  Future<CompleteMember> getCompleteMember(String memberId) async {
    return CompleteMember.fromJson(await getOne(memberId, suffix: "complete"));
  }

  Future<CompleteMember> getMe() async {
    return CompleteMember.fromJson(await getOne("me", suffix: "complete"));
  }
}
