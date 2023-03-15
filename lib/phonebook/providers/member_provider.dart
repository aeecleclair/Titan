import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/repositories/member_repository.dart';


final memberProvider = StateNotifierProvider<MemberProvider, Member>((ref) {
  return MemberProvider();
});

class MemberProvider extends StateNotifier<Member> {
  MemberProvider() : super(Member.empty());

  void setMember(Member i) {
    state = i;
  }

  void getMember(String id) async {
    state = await MemberRepository().getMember(id);
  }
}