import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationListNotifier extends ListNotifierAPI<AssociationComplete> {
  Openapi get associationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AssociationComplete>> build() {
    loadAssociations();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AssociationComplete>>> loadAssociations() async {
    return await loadList(associationRepository.phonebookAssociationsGet);
  }

  Future<bool> createAssociation(
    AppModulesPhonebookSchemasPhonebookAssociationBase association,
  ) async {
    return await add(
      () => associationRepository.phonebookAssociationsPost(body: association),
      association,
    );
  }

  Future<bool> updateAssociation(AssociationComplete association) async {
    return await update(
      () => associationRepository.phonebookAssociationsAssociationIdPatch(
        associationId: association.id,
        body: AssociationEdit(
          name: association.name,
          description: association.description,
          mandateYear: association.mandateYear,
        ),
      ),
      (association) => association.id,
      association,
    );
  }

  Future<bool> deleteAssociation(AssociationComplete association) async {
    return await delete(
      () => associationRepository.phonebookAssociationsAssociationIdDelete(
        associationId: association.id,
      ),
      (association) => association.id,
      association.id,
    );
  }

  Future<bool> deactivateAssociation(AssociationComplete association) async {
    return await update(
      () => associationRepository
          .phonebookAssociationsAssociationIdDeactivatePatch(
            associationId: association.id,
          ),
      (association) => association.id,
      association.copyWith(deactivated: true),
    );
  }

  Future<bool> updateAssociationGroups(AssociationComplete association) async {
    return await update(
      () => associationRepository.phonebookAssociationsAssociationIdGroupsPatch(
        associationId: association.id,
        body: AssociationGroupsEdit(
          associatedGroups: association.associatedGroups,
        ),
      ),
      (association) => association.id,
      association,
    );
  }
}

final associationListProvider =
    NotifierProvider<
      AssociationListNotifier,
      AsyncValue<List<AssociationComplete>>
    >(AssociationListNotifier.new);
