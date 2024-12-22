import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class MyCMMRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/me";

  Future<List<CMM>> getMyCMM() async {
    //return (await getList(suffix: '')).map((e) => CMM.fromJson(e)).toList();
    return [
      CMM(
          id: '1',
          date: DateTime.now(),
          user: SimpleUser(
              name: "Ñool",
              firstname: "Ñool",
              nickname: "Ñool",
              id: "A",
              accountType: AccountType(type: "Student")),
          path: "assets/images/cmm.jpg"),
      CMM(
          id: '2',
          date: DateTime.now(),
          user: SimpleUser(
              name: "Ñool",
              firstname: "Ñool",
              nickname: "Ñool",
              id: "A",
              accountType: AccountType(type: "Student")),
          path: "assets/images/cmm2.jpg")
    ];
  }

  Future<CMM> addCMM(CMM cmm) async {
    return CMM.fromJson(await create(cmm.toJson(), suffix: ''));
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }
}

final cmmRepositoryProvider = Provider<MyCMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return MyCMMRepository()..setToken(token);
});
