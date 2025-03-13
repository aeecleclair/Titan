import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
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

  Future<bool> deletePh(String phId) async {
    return await delete(
      () => phRepository.phPaperIdDelete(paperId: phId),
      (p) => p.id,
      phId,
    );
  }
}

final phListProvider =
    StateNotifierProvider<PhListNotifier, AsyncValue<List<PaperComplete>>>(
        (ref) {
  final phRepository = ref.watch(repositoryProvider);
  return PhListNotifier(phRepository: phRepository)..loadPhList();
});
