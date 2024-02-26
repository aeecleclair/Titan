import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';

final completeMemberProvider =
    StateNotifierProvider<CompleteMemberProvider, CompleteMember>((ref) {
  return CompleteMemberProvider();
});

class CompleteMemberProvider extends StateNotifier<CompleteMember> {
  CompleteMemberProvider() : super(CompleteMember.empty());

  void setCompleteMember(CompleteMember i) {
    state = i;
  }

  void setMember(Member i) {
    state = state.copyWith(member: i);
  }
}
