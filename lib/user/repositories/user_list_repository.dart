import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/class/simple_users.dart';

class UserListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<List<SimpleUser>> getAllUsers() async {
    return List<SimpleUser>.from(
      (await getList()).map((x) => SimpleUser.fromJson(x)),
    );
  }

  Future<List<SimpleUser>> searchUser(
    String query, {
    List<String>? includeId,
    List<String>? excludeId,
  }) async {
    String suffix = "search";
    if (query.isNotEmpty) {
      suffix += "?query=$query";
    }
    if (includeId != null) {
      for (final id in includeId) {
        suffix += "&includedGroups=$id";
      }
    }
    if (excludeId != null) {
      for (final id in excludeId) {
        suffix += "&excludedGroups=$id";
      }
    }
    return List<SimpleUser>.from(
      (await getList(suffix: suffix)).map((x) => SimpleUser.fromJson(x)),
    );
  }
}

final userListRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return UserListRepository()..setToken(token);
});
