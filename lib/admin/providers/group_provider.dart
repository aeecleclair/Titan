import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class GroupNotifier extends SingleNotifierAPI<CoreGroup> {
  Openapi get groupRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<CoreGroup> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<CoreGroup>> loadGroup(String groupId) async {
    return await load(() => groupRepository.groupsGroupIdGet(groupId: groupId));
  }

  Future<bool> addMember(CoreGroup group, CoreUserSimple user) async {
    return await update(
      () async => groupRepository.groupsMembershipPost(
        body: CoreMembership(groupId: group.id, userId: user.id),
      ),
      group,
    );
  }

  Future<bool> deleteMember(CoreGroup group, CoreUserSimple user) async {
    return await update(
      () async => groupRepository.groupsMembershipDelete(
        body: CoreMembershipDelete(groupId: group.id, userId: user.id),
      ),
      group,
    );
  }

  void setGroup(CoreGroup group) {
    state = AsyncValue.data(group);
  }
}

final groupProvider = NotifierProvider<GroupNotifier, AsyncValue<CoreGroup>>(
  GroupNotifier.new,
);
