import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/repositories/association_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AssociationListNotifier extends ListNotifier<Association> {
  final AssociationRepository associationRepository = AssociationRepository();
  AsyncValue<List<Association>> associationList = const AsyncValue.loading();
  AssociationListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    return await loadList(associationRepository.getAssociationList);
  }

  Future<bool> createAssociation(Association association) async {
    return await add(associationRepository.createAssociation, association);
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(
      associationRepository.updateAssociation,
      (associations, association) => associations
        ..[associations.indexWhere((g) => g.id == association.id)] =
            association,
      association,
    );
  }

  Future<bool> deleteAssociation(Association association) async {
    return await delete(
      associationRepository.deleteAssociation,
      (associations, association) =>
          associations..removeWhere((i) => i.id == association.id),
      association.id,
      association,
    );
  }

  Future<bool> deactivateAssociation(Association association) async {
    return await update(
      associationRepository.deactivateAssociation,
      (associations, association) => associations
        ..[associations.indexWhere((g) => g.id == association.id)] = association
            .copyWith(deactivated: true),
      association,
    );
  }

  Future<bool> updateAssociationGroups(Association association) async {
    return await update(
      associationRepository.updateAssociationGroups,
      (associations, association) => associations
        ..[associations.indexWhere((g) => g.id == association.id)] =
            association,
      association,
    );
  }
}

final associationListProvider =
    StateNotifierProvider<
      AssociationListNotifier,
      AsyncValue<List<Association>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      AssociationListNotifier notifier = AssociationListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadAssociations();
      });
      return notifier;
    });
