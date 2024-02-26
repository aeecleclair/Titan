import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/repositories/role_tags_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:tuple/tuple.dart';


class RolesTagsNotifier extends SingleNotifier<Tuple2<RolesTags,List<bool>>> {
  final RolesTagsRepository rolesTagsRepository = RolesTagsRepository();
    RolesTagsNotifier({required String token})
        : super(const AsyncValue.loading()) {
      rolesTagsRepository.setToken(token);
    }

  void setRole(RolesTags i) {
    state = AsyncValue.data(Tuple2(i, state.value!.item2));
  }

  Future<AsyncValue<Tuple2<RolesTags,List<bool>>>> loadRolesTags() async {
    return await load(() async => rolesTagsRepository.getRolesTags());
  }

  void resetChecked() {
    final checked = state.value!.item2;
    state = AsyncValue.data(Tuple2(state.value!.item1, List<bool>.filled(checked.length, false)));
  }
}

final rolesTagsProvider = StateNotifierProvider<RolesTagsNotifier, AsyncValue<Tuple2<RolesTags,List<bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  RolesTagsNotifier notifier  = RolesTagsNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRolesTags();
  });
  return notifier;
});