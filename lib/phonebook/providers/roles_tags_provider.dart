import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/repositories/role_tags_repository.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class RolesTagsNotifier extends MapNotifier<String, bool> {
  final RolesTagsRepository rolesTagsRepository = RolesTagsRepository();
  RolesTagsNotifier({required String token}) {
    rolesTagsRepository.setToken(token);
  }

  Future<void> loadRolesTags() async {
    loadTList([]);
    final result = await rolesTagsRepository.getRolesTags();
    for (int i = 0; i < result.tags.length; i++) {
      setTData(result.tags[i], const AsyncData([false]));
    }
  }

  void resetChecked() {
    state.forEach((key, value) => state[key] = const AsyncData([false]));
    state = Map.of(state);
  }

  void loadRoleTagsFromMember(CompleteMember member, Association association) {
    List<String> roleTags = member.getRolesTags(association.id);
    for (var value in roleTags) {
      state[value] = const AsyncData([true]);
    }
    state = Map.of(state);
  }
}

final rolesTagsProvider =
    StateNotifierProvider<
      RolesTagsNotifier,
      Map<String, AsyncValue<List<bool>>?>
    >((ref) {
      final token = ref.watch(tokenProvider);
      RolesTagsNotifier notifier = RolesTagsNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadRolesTags();
      });
      return notifier;
    });
