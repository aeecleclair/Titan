import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/repositories/role_tags_repository.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RolesTagsNotifier extends MapNotifier<String, bool> {
  final RolesTagsRepository rolesTagsRepository = RolesTagsRepository();
  RolesTagsNotifier({required String token}) {
    rolesTagsRepository.setToken(token);
  }



  // void setRole(RolesTags i) {
  //   state = AsyncValue.data(Tuple2(i, state.value!.item2));
  // }

  Future<void> loadRolesTags() async {
    loadTList([]);
    final result = await rolesTagsRepository.getRolesTags();
    for (int i = 0; i < result.tags.length; i++) {
        setTData(result.tags[i], const AsyncData([false]));
    }
  }

  void resetChecked() {
    state.maybeWhen(data: (d) {
      for (int i = 0; i < d.length; i++) {
        d[d.keys.toList()[i]] = const AsyncData([false]);
      }
      state = AsyncValue.data(d);
    }, orElse: () {});
  }

  // void setChecked(int index, bool value) {
  //   List<bool> checked = state.value!.item2;
  //   checked[index] = value;
  //   state = AsyncValue.data(Tuple2(state.value!.item1, checked));
  // }

  void loadRoleTagsFromMember(CompleteMember member, Association association) {
    List<String> roleTags = member.getRolesTags(association.id);
    state.maybeWhen(data: (d) {
      for (int i = 0; i < roleTags.length; i++) {
        d[roleTags[i]] = const AsyncData([true]);
      }
      state = AsyncValue.data(d);
    }, orElse: () {});
  }
}

final rolesTagsProvider = StateNotifierProvider<RolesTagsNotifier,
    AsyncValue<Map<String,AsyncValue<List<bool>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  RolesTagsNotifier notifier = RolesTagsNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRolesTags();
  });
  return notifier;
});
