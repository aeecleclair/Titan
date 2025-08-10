import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/repositories/role_tags_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class RolesTagsNotifier extends ListNotifier<String> {
  final RolesTagsRepository rolesTagsRepository = RolesTagsRepository();
  RolesTagsNotifier({required String token})
    : super(const AsyncValue.loading()) {
    rolesTagsRepository.setToken(token);
  }

  Future<AsyncValue<List<String>>> loadRolesTags() async {
    return loadList(rolesTagsRepository.getRolesTags);
  }
}

final rolesTagsProvider =
    StateNotifierProvider<RolesTagsNotifier, AsyncValue<List<String>>>((ref) {
      final token = ref.watch(tokenProvider);
      RolesTagsNotifier notifier = RolesTagsNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadRolesTags();
      });
      return notifier;
    });
