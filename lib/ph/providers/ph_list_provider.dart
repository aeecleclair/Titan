import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/ph/adapters/ph.dart';

class PhListNotifier extends ListNotifierAPI<PaperComplete> {
  final Openapi phRepository;
  PhListNotifier({required this.phRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PaperComplete>>> loadPhList() async {
    return await loadList(phRepository.phGet);
  }

  Future<bool> addPh(PaperBase ph) async {
    return await add(() => phRepository.phPost(body: ph), ph);
  }

  Future<bool> editPh(PaperComplete ph) async {
    return await update(
      () => phRepository.phPaperIdPatch(
        paperId: ph.id,
        body: ph.toPaperUpdate(),
      ),
      (ph) => ph.id,
      ph,
    );
  }

  Future<bool> deletePh(PaperComplete ph) async {
    return await delete(
      () => phRepository.phPaperIdDelete(paperId: ph.id),
      (phs) => phs..removeWhere((phToCheck) => phToCheck.id == ph.id),
    );
  }
}

final phListProvider =
    StateNotifierProvider<PhListNotifier, AsyncValue<List<PaperComplete>>>(
        (ref) {
  final phRepository = ref.watch(repositoryProvider);
  final notifier = PhListNotifier(phRepository: phRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadPhList();
  });
  return notifier;
});
