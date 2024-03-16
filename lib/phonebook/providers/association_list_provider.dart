import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

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
}

final associationListProvider = StateNotifierProvider<AssociationListNotifier,
    AsyncValue<List<Association>>>((ref) {
  final token = ref.watch(tokenProvider);
  AssociationListNotifier notifier = AssociationListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociations();
  });
  return notifier;
});
