import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/repository/repository.dart';

class CompleteMemberProvider extends StateNotifier<MemberComplete> {
  final Openapi memberRepository;
  CompleteMemberProvider({required this.memberRepository})
      : super(EmptyModels.empty<MemberComplete>());

  void setCompleteMember(MemberComplete i) {
    state = i;
  }

  void setMember(MemberComplete i) {
    state = i;
  }

  Future<bool> loadMemberComplete() async {
    try {
      final data =
          await memberRepository.phonebookMemberUserIdGet(userId: state.id);
      if (data.isSuccessful) {
        state = data.body!;
        return true;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

final completeMemberProvider =
    StateNotifierProvider<CompleteMemberProvider, MemberComplete>((ref) {
  final memberRepository = ref.watch(repositoryProvider);
  return CompleteMemberProvider(memberRepository: memberRepository);
});
