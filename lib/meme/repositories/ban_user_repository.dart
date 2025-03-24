import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class BanRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "meme/users/";

  Future<List<SimpleUser>> getBannedUsers() async {
    return (await getList(suffix: 'banned'))
        .map((e) => SimpleUser.fromJson(e))
        .toList();
  }

  Future<bool> banUser(String id) async {
    return await create(
      "",
      suffix: '$id/ban',
    );
  }

  Future<bool> unbanUser(String id) async {
    return await create(
      "",
      suffix: '$id/unban',
    );
  }
}

final banUserProvider = Provider<BanRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return BanRepository()..setToken(token);
});
