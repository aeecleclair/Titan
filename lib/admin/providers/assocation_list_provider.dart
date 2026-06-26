import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationListNotifier extends ListNotifierAPI<Association> {
  Openapi get associationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Association>> build() {
    loadAssociations();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    return await loadList(associationRepository.associationsGet);
  }

  Future<bool> createAssociation(Association association) async {
    return await add(
      () => associationRepository.associationsPost(
        body: AppCoreAssociationsSchemasAssociationsAssociationBase(
          name: association.name,
          groupId: association.groupId,
        ),
      ),
      association,
    );
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(
      () => associationRepository.associationsAssociationIdPatch(
        associationId: association.id,
        body: AssociationUpdate(
          name: association.name,
          groupId: association.groupId,
        ),
      ),
      (association) => association.id,
      association,
    );
  }

  void setAssociation(Association association) {
    state.whenData((d) {
      if (d.indexWhere((g) => g.id == association.id) == -1) return;
      state = AsyncValue.data(
        d..[d.indexWhere((g) => g.id == association.id)] = association,
      );
    });
  }
}

final associationListProvider =
    NotifierProvider<AssociationListNotifier, AsyncValue<List<Association>>>(
      AssociationListNotifier.new,
    );
