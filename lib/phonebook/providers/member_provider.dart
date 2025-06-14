import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/member.dart';

final memberProvider = StateNotifierProvider<MemberProvider, Member>((ref) {
  return MemberProvider();
});

class MemberProvider extends StateNotifier<Member> {
  MemberProvider() : super(Member.empty());

  void setMember(Member i) {
    state = i;
  }
}
