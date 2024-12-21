import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class CMMRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/me";

  Future<List<CMM>> getMyCMM() async {
    //return (await getList(suffix: '')).map((e) => CMM.fromJson(e)).toList();
    return [CMM(id: '1', date: DateTime.now(), userId: '1')];
  }

  Future<CMM> addCMM(CMM cmm) async {
    return CMM.fromJson(await create(cmm.toJson(), suffix: ''));
  }

  Future<bool> deleteCMM(String id) async {
    return await delete(id);
  }
}

final cmmRepositoryProvider = Provider<CMMRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CMMRepository()..setToken(token);
});
