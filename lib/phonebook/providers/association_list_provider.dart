import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/phonebook/adapters/association.dart';

class AssociationListNotifier extends ListNotifierAPI<AssociationComplete> {
  final Openapi associationRepository;
  AssociationListNotifier({required this.associationRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AssociationComplete>>> loadAssociations() async {
    return await loadList(associationRepository.phonebookAssociationsGet);
  }

  Future<bool> createAssociation(AssociationBase association) async {
    return await add(
      () => associationRepository.phonebookAssociationsPost(body: association),
      association,
    );
  }

  Future<bool> updateAssociation(AssociationComplete association) async {
    return await update(
      () => associationRepository.phonebookAssociationsAssociationIdPatch(
        associationId: association.id,
        body: association.toAssociationEdit(),
      ),
      (association) => association.id,
      association,
    );
  }

  Future<bool> deleteAssociation(String associationId) async {
    return await delete(
      () => associationRepository.phonebookAssociationsAssociationIdDelete(
        associationId: associationId,
      ),
      (a) => a.id,
      associationId,
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
        body: association.toAssociationGroupsEdit(),
      ),
      (association) => association.id,
      association,
    );
  }
}

final associationListProvider = StateNotifierProvider<AssociationListNotifier,
    AsyncValue<List<AssociationComplete>>>((ref) {
  final associationRepository = ref.watch(repositoryProvider);
  AssociationListNotifier notifier =
      AssociationListNotifier(associationRepository: associationRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociations();
  });
  return notifier;
});
