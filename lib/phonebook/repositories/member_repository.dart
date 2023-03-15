import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/post.dart';
import 'package:myecl/tools/repository/repository.dart';

class MemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/member/";

  Future<List<Post>> getMemberPostList(int memberId) async {
    return List<Post>.from(
        (await getList(suffix: "/$memberId/posts")).map((x) => Post.fromJSON(x)));
  }

  Future<Member> getMember(String memberId) async {
    return Member.fromJSON(await getOne(memberId));
  }

  Future<CompleteMember> getCompleteMember(String memberId) async {
    return CompleteMember.fromJSON(await getOne(memberId, suffix: "complete"));
  }
}