import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/user/class/list_users.dart';

class MyCMMRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/";

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

  Future<Image> addCMM(Uint8List bytes) async {
    final uint8List = await addLogo(bytes, "", suffix: "memes");
    return Image.memory(uint8List);
  }

  reactToCMM(String id, bool positive) async {
    await create(cmm.toJson(), suffix: 'memes/$id/vote');
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }
}

final cmmRepositoryProvider = Provider<MyCMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return MyCMMRepository()..setToken(token);
});
