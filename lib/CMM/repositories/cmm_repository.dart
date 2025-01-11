import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/tools/functions.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class CMMRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/";

  Future<List<CMM>> getCMM(int page) async {
    return (await getList(suffix: 'memes/?sort_by=best&n_page=1'))
        .map((e) => CMM.fromJson(e))
        .toList();
  }

  Future<Uint8List> getCMMImage(String id) async {
    final uint8List = await getLogo("", suffix: "memes/$id/img");
    // if (uint8List.isEmpty) {
    //   return Image.asset(getTitanLogo());
    // }
    return uint8List;
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
