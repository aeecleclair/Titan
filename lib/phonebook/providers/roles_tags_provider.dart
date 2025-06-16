import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/repositories/role_tags_repository.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class RolesTagsNotifier extends MapNotifier<String, bool> {
  final RolesTagsRepository rolesTagsRepository;
  RolesTagsNotifier(this.rolesTagsRepository);

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
      final rolesTagsRepository = ref.watch(rolesTagsRepositoryProvider);
      RolesTagsNotifier notifier = RolesTagsNotifier(rolesTagsRepository);
      notifier.loadRolesTags();
      return notifier;
    });
