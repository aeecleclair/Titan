import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class GroupNotifier extends SingleNotifier2<CoreGroup> {
  final Openapi groupRepository;
  GroupNotifier({required this.groupRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<CoreGroup>> loadGroup(String groupId) async {
    return await load(
      () async => groupRepository.groupsGroupIdGet(groupId: groupId),
    );
  }

  Future<bool> addMember(CoreGroup group, CoreUserSimple user) async {
    return await update(
      (group) async => groupRepository.groupsMembershipPost(
        body: CoreMembership(userId: user.id, groupId: group.id),
      ),
      group,
    );
  }

  Future<bool> deleteMember(CoreGroup group, CoreUserSimple user) async {
    return await update(
      (group) async => groupRepository.groupsMembershipDelete(
        body: CoreMembershipDelete(userId: user.id, groupId: group.id),
      ),
      group,
    );
  }

  void setGroup(CoreGroup group) {
    state = AsyncValue.data(group);
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, AsyncValue<CoreGroup>>((ref) {
  final groupRepository = ref.watch(repositoryProvider);
  return GroupNotifier(groupRepository: groupRepository);
});
