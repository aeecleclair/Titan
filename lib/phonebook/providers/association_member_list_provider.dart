import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/repositories/association_member_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationMemberListNotifier extends ListNotifier<CompleteMember> {
  final AssociationMemberRepository associationMemberRepository = AssociationMemberRepository();
  AssociationMemberListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    associationMemberRepository.setToken(token);
  }

  Future<AsyncValue<List<CompleteMember>>> loadMembers(String associationId) async {
    return await loadList(() async => associationMemberRepository.getAssociationMemberList(associationId));
  }
}

final associationMemberListProvider =
    StateNotifierProvider<AssociationMemberListNotifier, AsyncValue<List<CompleteMember>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  AssociationMemberListNotifier provider = AssociationMemberListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final association = ref.watch(associationProvider);
    await provider.loadMembers(association.id);
  });
  return provider;
});