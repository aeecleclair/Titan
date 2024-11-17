import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/sg/class/sg.dart';
import 'package:myecl/sg/repositories/sg_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SgListNotifier extends ListNotifier<Sg> {
  final SgRepository _sgRepository = SgRepository();
  SgListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _sgRepository.setToken(token);
  }

  Future<AsyncValue<List<Sg>>> loadSgList() async {
    return await loadList(() async => _sgRepository.getAllSg());
  }

  Future<bool> addSg(Sg sg) async {
    return await add(_sgRepository.addSg, sg);
  }

  Future<bool> editSg(Sg sg) async {
    return await update(
      _sgRepository.editSg,
      (sgs, sg) =>
          sgs..[sgs.indexWhere((sgToCheck) => sgToCheck.id == sg.id)] = sg,
      sg,
    );
  }

  Future<bool> deleteSg(Sg sg) async {
    return await delete(
      _sgRepository.deleteSg,
      (sgs, sg) => sgs..removeWhere((sgToCheck) => sgToCheck.id == sg.id),
      sg.id,
      sg,
    );
  }
}

final sgListProvider =
    StateNotifierProvider<SgListNotifier, AsyncValue<List<Sg>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = SgListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadSgList();
  });
  return notifier;
});
