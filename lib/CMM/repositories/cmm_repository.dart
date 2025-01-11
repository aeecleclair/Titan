import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/tools/functions.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class CMMRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/";

  Future<List<CMM>> getCMM(int page, int pagesize) async {
    //return (await getList(suffix: '')).map((e) => CMM.fromJson(e)).toList();
    if (page == 0) {
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
    return [
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

  Future<bool> addVoteToCMM(String id, bool positive) async {
    return await create(toJson(positive), suffix: 'memes/$id/vote');
  }

  Future<bool> deleteVoteToCMM(String id) async {
    return await delete(id, suffix: 'memes/$id/vote');
  }
}

final cmmRepositoryProvider = Provider<CMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CMMRepository()..setToken(token);
});
