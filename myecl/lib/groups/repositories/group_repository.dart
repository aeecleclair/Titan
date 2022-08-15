import 'package:myecl/groups/class/group.dart';
import 'package:myecl/tools/repository/repository.dart';

class GroupRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "groups/";

  Future<List<Group>> getGroupList() async {
    return List<Group>.from((await getList()).map((x) => Group.fromJson(x)));
  }

  Future<Group> getGroup(String groupId) async {
    return Group.fromJson(await getOne(groupId));
  }

  Future<bool> deleteGroup(String groupId) async {
    return await delete(groupId);
  }

  Future<bool> updateGroup(Group group) async {
    return await update(group.toJson(), group.id);
  }

  Future<Group> createGroup(Group group) async {
    return Group.fromJson(await create(group.toJson()));
  }
  // TODO: POST /groups/membership
}
