import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class HiddenCMMRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/memes/";

  Future<List<CMM>> getBannedCMM(int page) async {
    return (await getList(suffix: 'hidden?n_page=$page'))
        .map((e) => CMM.fromJson(e))
        .toList();
  }

  Future<bool> hideCMM(String id) async {
    return await create(
      "",
      suffix: '$id/hide',
    );
  }

  Future<bool> showCMM(String id) async {
    return await create(
      "",
      suffix: '$id/show',
    );
  }
}

final bannedCMMProvider = Provider<HiddenCMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return HiddenCMMRepository()..setToken(token);
});
