import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/repositories/member_repository.dart';

final completeMemberProvider =
    StateNotifierProvider<CompleteMemberProvider, CompleteMember>((ref) {
  final token = ref.watch(tokenProvider);
  return CompleteMemberProvider(token: token);
});

class CompleteMemberProvider extends StateNotifier<CompleteMember> {
  final MemberRepository memberRepository = MemberRepository();
  CompleteMemberProvider({required String token})
      : super(CompleteMember.empty()) {
    memberRepository.setToken(token);
  }

  void setCompleteMember(CompleteMember i) {
    state = i;
  }

  void setMember(Member i) {
    state = state.copyWith(member: i);
  }

  Future<bool> loadMember(String userId) async {
    try {
      state = await memberRepository.getCompleteMember(userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loadMembership() async {
    try {
      final data = await memberRepository.getCompleteMember(state.member.id);
      state = state.copyWith(membership: data.memberships);
      return true;
    } catch (e) {
      return false;
    }
  }
}
