import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/member.dart';
import 'package:titan/phonebook/repositories/member_repository.dart';

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

  Future<bool> loadMemberComplete() async {
    try {
      final data = await memberRepository.getCompleteMember(state.member.id);
      state = state.copyWith(member: data.member, membership: data.memberships);
      return true;
    } catch (e) {
      return false;
    }
  }
}
