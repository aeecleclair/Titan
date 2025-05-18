import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class RolesTagsNotifier extends MapNotifier<String, bool> {
  final Openapi rolesTagsRepository;
  RolesTagsNotifier({required this.rolesTagsRepository}) : super();

  Future<void> loadRolesTags() async {
    loadTList([]);
    final result = await rolesTagsRepository.phonebookRoletagsGet();
    if (result.isSuccessful) {
      for (int i = 0; i < result.body!.tags.length; i++) {
        setTData(result.body!.tags[i], const AsyncData([false]));
      }
    }
  }

  void resetChecked() {
    state.forEach((key, value) => state[key] = const AsyncData([false]));
    state = Map.of(state);
  }

  void loadRoleTagsFromMember(
    MemberComplete member,
    AssociationComplete association,
  ) {
    List<String> roleTags = member.memberships
        .where((element) => element.associationId == association.id)
        .map((e) => e.roleTags as List<String>)
        .expand((element) => element)
        .toList();
    for (var value in roleTags) {
      state[value] = const AsyncData([true]);
    }
    state = Map.of(state);
  }
}

final rolesTagsProvider = StateNotifierProvider<RolesTagsNotifier,
    Map<String, AsyncValue<List<bool>>?>>((ref) {
  final rolesTagsRepository = ref.watch(repositoryProvider);
  return RolesTagsNotifier(rolesTagsRepository: rolesTagsRepository)
    ..loadRolesTags();
});
