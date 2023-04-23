import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/repositories/role_tags_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';


class RolesTagsNotifier extends SingleNotifier<RolesTags> {
  final RolesTagsRepository rolesTagsRepository = RolesTagsRepository();
    RolesTagsNotifier({required String token})
        : super(const AsyncValue.loading()) {
      rolesTagsRepository.setToken(token);
    }

  void setRole(RolesTags i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<RolesTags>> loadRolesTags() async {
    return await load(() async => rolesTagsRepository.getRolesTags());
  }
}

final rolesTagsProvider = StateNotifierProvider<RolesTagsNotifier, AsyncValue<RolesTags>>((ref) {
  final token = ref.watch(tokenProvider);
  RolesTagsNotifier notifier  = RolesTagsNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRolesTags();
  });
  return notifier;
});