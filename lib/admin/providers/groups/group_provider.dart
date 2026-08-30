import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/repositories/group_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/user/class/simple_users.dart';

class GroupNotifier extends SingleNotifier<Group> {
  final GroupRepository groupRepository;
  GroupNotifier({required this.groupRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Group>> loadGroup(String groupId) async {
    return await load(() async => groupRepository.getGroup(groupId));
  }

  Future<bool> addMember(Group group, SimpleUser user) async {
    return await update(
      (group) async => groupRepository.addMember(group, user),
      group,
    );
  }

  Future<bool> deleteMember(Group group, SimpleUser user) async {
    return await update(
      (group) async => groupRepository.deleteMember(group, user),
      group,
    );
  }

  void setGroup(Group group) {
    state = AsyncValue.data(group);
  }
}

final groupProvider = StateNotifierProvider<GroupNotifier, AsyncValue<Group>>((
  ref,
) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  return GroupNotifier(groupRepository: groupRepository);
});
