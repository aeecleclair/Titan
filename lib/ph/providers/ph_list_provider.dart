import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class PhListNotifier extends ListNotifierAPI<PaperComplete> {
  Openapi get phRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<PaperComplete>> build() {
    loadPhList();
    return const AsyncValue.loading();
  }

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
        body: PaperUpdate(name: ph.name, releaseDate: ph.releaseDate),
      ),
      (ph) => ph.id,
      ph,
    );
  }

  Future<bool> deletePh(PaperComplete ph) async {
    return await delete(
      () => phRepository.phPaperIdDelete(paperId: ph.id),
      (ph) => ph.id,
      ph.id,
    );
  }
}

final phListProvider =
    NotifierProvider<PhListNotifier, AsyncValue<List<PaperComplete>>>(
      PhListNotifier.new,
    );
