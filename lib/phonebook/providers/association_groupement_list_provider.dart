import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationGroupementListNotifier
    extends ListNotifierAPI<AssociationGroupement> {
  Openapi get associationGroupementRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AssociationGroupement>> build() {
    loadAssociationGroupement();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AssociationGroupement>>>
  loadAssociationGroupement() async {
    return await loadList(
      associationGroupementRepository.phonebookGroupementsGet,
    );
  }

  Future<bool> createAssociationGroupement(
    AssociationGroupementBase associationGroupement,
  ) async {
    return await add(
      () => associationGroupementRepository.phonebookGroupementsPost(
        body: associationGroupement,
      ),
      associationGroupement,
    );
  }

  Future<bool> updateAssociationGroupement(
    String groupementId,
    AssociationGroupement associationGroupement,
  ) async {
    return await update(
      () =>
          associationGroupementRepository.phonebookGroupementsGroupementIdPatch(
            groupementId: groupementId,
            body: AssociationGroupementBase(
              name: associationGroupement.name,
              managerGroupId: associationGroupement.managerGroupId,
            ),
          ),
      (groupement) => groupement.id,
      associationGroupement,
    );
  }

  Future<bool> deleteAssociationGroupement(String groupementId) async {
    return await delete(
      () => associationGroupementRepository
          .phonebookGroupementsGroupementIdDelete(groupementId: groupementId),
      (associationGroupement) => associationGroupement.id,
      groupementId,
    );
  }
}

final associationGroupementListProvider =
    NotifierProvider<
      AssociationGroupementListNotifier,
      AsyncValue<List<AssociationGroupement>>
    >(() => AssociationGroupementListNotifier());
