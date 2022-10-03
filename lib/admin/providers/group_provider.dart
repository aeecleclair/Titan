import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/repositories/group_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/class/list_users.dart';

class GroupNotifier extends SingleNotifier<Group> {
  final GroupRepository _groupRepository = GroupRepository();
  GroupNotifier({required String token}) : super(const AsyncValue.loading()) {
    _groupRepository.setToken(token);
  }

  Future<AsyncValue<Group>> loadGroup(String groupId) async {
    return await load(() async => _groupRepository.getGroup(groupId));
  }

  Future<bool> addMember(Group group, SimpleUser user) async {
    return await update(
        (group) async => _groupRepository.addMember(group, user), group);
  }

  Future<bool> deleteMember(Group group, SimpleUser user) async {
    return await update(
        (group) async => _groupRepository.deleteMember(group, user), group);
  }

  void setGroup(Group group) {
    state = AsyncValue.data(group);
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, AsyncValue<Group>>((ref) {
  final token = ref.watch(tokenProvider);
  return GroupNotifier(token: token);
});
