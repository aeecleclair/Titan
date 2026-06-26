import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class GroupListNotifier extends ListNotifierAPI<CoreGroupSimple> {
  Openapi get groupRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<CoreGroupSimple>> build() {
    loadGroups();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<CoreGroupSimple>>> loadGroups() async {
    return await loadList(groupRepository.groupsGet);
  }

  Future<bool> createGroup(CoreGroupSimple group) async {
    return await add(
      () => groupRepository.groupsPost(
        body: CoreGroupCreate(name: group.name, description: group.description),
      ),
      group,
    );
  }

  Future<bool> updateGroup(CoreGroupSimple group) async {
    return await update(
      () => groupRepository.groupsGroupIdPatch(
        groupId: group.id,
        body: CoreGroupUpdate(name: group.name, description: group.description),
      ),
      (group) => group.id,
      group,
    );
  }

  Future<bool> deleteGroup(CoreGroupSimple group) async {
    return await delete(
      () => groupRepository.groupsGroupIdDelete(groupId: group.id),
      (group) => group.id,
      group.id,
    );
  }

  void setGroup(CoreGroupSimple group) {
    state.whenData((d) {
      if (d.indexWhere((g) => g.id == group.id) == -1) return;
      state = AsyncValue.data(
        d..[d.indexWhere((g) => g.id == group.id)] = group,
      );
    });
  }
}

final allGroupListProvider =
    NotifierProvider<GroupListNotifier, AsyncValue<List<CoreGroupSimple>>>(
      GroupListNotifier.new,
    );

final allGroupList = Provider<List<CoreGroupSimple>>((ref) {
  return ref
      .watch(allGroupListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
