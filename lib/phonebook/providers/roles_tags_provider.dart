import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/repositories/role_tags_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:tuple/tuple.dart';

class RolesTagsNotifier extends SingleNotifier<Tuple2<RolesTags, List<bool>>> {
  final RolesTagsRepository rolesTagsRepository = RolesTagsRepository();
  RolesTagsNotifier({required String token})
      : super(const AsyncValue.loading()) {
    rolesTagsRepository.setToken(token);
  }

  void setRole(RolesTags i) {
    state = AsyncValue.data(Tuple2(i, state.value!.item2));
  }

  Future<AsyncValue<Tuple2<RolesTags, List<bool>>>> loadRolesTags() async {
    return await load(() async => rolesTagsRepository.getRolesTags());
  }

  void resetChecked() {
    final checked = state.value!.item2;
    state = AsyncValue.data(
        Tuple2(state.value!.item1, List<bool>.filled(checked.length, false)));
  }

  void setChecked(int index, bool value) {
    List<bool> checked = state.value!.item2;
    checked[index] = value;
    state = AsyncValue.data(Tuple2(state.value!.item1, checked));
  }

  void loadRoleTagsFromMember(CompleteMember member, Association association) {
    final checked = state.value!.item2;
    List<String> roleTags = member.getRolesTags(association.id);
    for (int i = 0; i < checked.length; i++) {
      checked[i] = roleTags.contains(state.value!.item1.tags[i]);
    }
    state = AsyncValue.data(Tuple2(state.value!.item1, checked));
  }
}

final rolesTagsProvider = StateNotifierProvider<RolesTagsNotifier,
    AsyncValue<Tuple2<RolesTags, List<bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  RolesTagsNotifier notifier = RolesTagsNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRolesTags();
  });
  return notifier;
});
