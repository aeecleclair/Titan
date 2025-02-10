import 'dart:async';
import 'dart:typed_data';
import 'package:myecl/tools/repository/logo_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/auth/providers/openid_provider.dart';

class MyCMMRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/memes/";

  Future<List<CMM>> getMyCMM(int page) async {
    return (await getList(suffix: '')).map((e) => CMM.fromJson(e)).toList();
  }

  Future<bool> addCMM(Uint8List bytes) async {
    try {
      await addLogo(bytes, "", suffix: "");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }
}

final cmmRepositoryProvider = Provider<MyCMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return MyCMMRepository()..setToken(token);
});
