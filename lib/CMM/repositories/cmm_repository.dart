import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class CMMRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/";

  Future<List<CMM>> getAllCMM() async {
    return (await getList(suffix: '')).map((e) => CMM.fromJson(e)).toList();
  }

  Future<CMM> addCMM(CMM cmm) async {
    return CMM.fromJson(await create(cmm.toJson(), suffix: ''));
  }

  Future<bool> editCMM(CMM cmm) async {
    return await update(cmm.toJson(), cmm.id);
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }
}

final cmmRepositoryProvider = Provider<CMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CMMRepository()..setToken(token);
});
