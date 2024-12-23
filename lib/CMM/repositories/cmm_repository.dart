import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class CMMRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/";

  Future<List<CMM>> getCMM() async {
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
          accountType: AccountType(type: "Student"),
        ),
        path: "assets/images/cmm.jpg",
        vote: 1,
        score: 300,
      ),
      CMM(
        id: '2',
        date: DateTime.now(),
        user: SimpleUser(
          name: "Ñool",
          firstname: "Ñool",
          nickname: "Ñool",
          id: "A",
          accountType: AccountType(type: "Student"),
        ),
        path: "assets/images/cmm2.jpg",
        vote: -1,
        score: 439,
      ),
    ];
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }
}

final cmmRepositoryProvider = Provider<CMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CMMRepository()..setToken(token);
});
