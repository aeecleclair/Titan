import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationListNotifier extends ListNotifier2<AssociationComplete> {
  final Openapi associationRepository;
  AssociationListNotifier({required this.associationRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AssociationComplete>>> loadAssociations() async {
    return await loadList(associationRepository.phonebookAssociationsGet);
  }

  Future<bool> createAssociation(AssociationBase association) async {
    return await add(
        () =>
            associationRepository.phonebookAssociationsPost(body: association),
        association);
  }

  Future<bool> updateAssociation(AssociationComplete association) async {
    return await update(
      () => associationRepository.phonebookAssociationsAssociationIdPatch(
          associationId: association.id,
          body: AssociationEdit(
            name: association.name,
            description: association.description,
            kind: association.kind,
            mandateYear: association.mandateYear,
          )),
      (associations, association) => associations
        ..[associations.indexWhere((g) => g.id == association.id)] =
            association,
      association,
    );
  }

  Future<bool> deleteAssociation(AssociationComplete association) async {
    return await delete(
      () => associationRepository.phonebookAssociationsAssociationIdDelete(
          associationId: association.id),
      (associations, association) =>
          associations..removeWhere((i) => i.id == association.id),
      association,
    );
  }

  Future<bool> deactivateAssociation(AssociationComplete association) async {
    return await update(
      () => associationRepository
          .phonebookAssociationsAssociationIdDeactivatePatch(
              associationId: association.id),
      (associations, association) => associations
        ..[associations.indexWhere((g) => g.id == association.id)] =
            association.copyWith(deactivated: true),
      association,
    );
  }

  Future<bool> updateAssociationGroups(AssociationComplete association) async {
    return await update(
      () => associationRepository.phonebookAssociationsAssociationIdGroupsPatch(
          associationId: association.id,
          body: AssociationGroupsEdit(
              associatedGroups: association.associatedGroups)),
      (associations, association) => associations
        ..[associations.indexWhere((g) => g.id == association.id)] =
            association,
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
