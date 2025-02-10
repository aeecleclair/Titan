import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class CMMRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/memes/";

  Future<List<CMM>> getCMM(int page) async {
    return (await getList(suffix: '?sort_by=best&n_page=$page'))
        .map((e) => CMM.fromJson(e))
        .toList();
  }

  Future<Uint8List> getCMMImage(String id) async {
    final uint8List = await getLogo("", suffix: "$id/img");
    // if (uint8List.isEmpty) {
    //   return Image.asset(getTitanLogo());
    // }
    return uint8List;
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }

  Future<bool> addVoteToCMM(CMM cmm, bool positive) async {
    return await create(
      cmm.toJson(),
      suffix: '${cmm.id}/vote/?positive=$positive',
    );
  }

  Future<bool> updateVoteToCMM(CMM cmm, bool positive) async {
    return await update(
      cmm.toJson(),
      cmm.id,
      suffix: '/vote/?positive=$positive',
    );
  }

  Future<bool> deleteVoteToCMM(String id) async {
    return await delete(id, suffix: 'memes/$id/vote');
  }
}

final cmmRepositoryProvider = Provider<CMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CMMRepository()..setToken(token);
});
