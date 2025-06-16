import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/simple_users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';

class GroupRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "groups/";

  GroupRepository(super.ref);

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
    final response = await http.delete(
      Uri.parse("${Repository.host}${ext}membership"),
      headers: headers,
      body: json.encode({"user_id": user.id, "group_id": group.id}),
    );
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update item");
    }
  }
}

final groupRepositoryProvider = Provider((ref) {
  return GroupRepository(ref);
});
