import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/class/simple_users.dart';

class GroupRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "groups/";

  Future<List<SimpleGroup>> getGroupList() async {
    return List<SimpleGroup>.from(
      (await getList()).map((x) => SimpleGroup.fromJson(x)),
    );
  }

  Future<Group> getGroup(String groupId) async {
    return Group.fromJson(await getOne(groupId));
  }

  Future<bool> deleteGroup(String groupId) async {
    return await delete(groupId);
  }

  Future<bool> updateGroup(SimpleGroup group) async {
    return await update(group.toJson(), group.id);
  }

  Future<SimpleGroup> createGroup(SimpleGroup group) async {
    return SimpleGroup.fromJson(await create(group.toJson()));
  }

  Future<bool> addMember(Group group, SimpleUser user) async {
    await create({
      "user_id": user.id,
      "group_id": group.id,
    }, suffix: "membership");
    return true;
  }

  Future<bool> deleteMember(Group group, SimpleUser user) async {
    return await delete(
      "membership",
      body: {"user_id": user.id, "group_id": group.id},
    );
  }
}

final groupRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return GroupRepository()..setToken(token);
});
