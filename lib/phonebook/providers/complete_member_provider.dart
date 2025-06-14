import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/repositories/member_repository.dart';

final completeMemberProvider =
    StateNotifierProvider<CompleteMemberProvider, CompleteMember>((ref) {
      final memberRepository = ref.watch(memberRepositoryProvider);
      return CompleteMemberProvider(memberRepository);
    });

class CompleteMemberProvider extends StateNotifier<CompleteMember> {
  final MemberRepository memberRepository;
  CompleteMemberProvider(this.memberRepository) : super(CompleteMember.empty());

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
