import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/repositories/association_groupement_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/providers/user_provider.dart';

class AssociationGroupementListNotifier
    extends ListNotifier<AssociationGroupement> {
  final AssociationGroupementRepository associationGroupementRepository =
      AssociationGroupementRepository();
  AssociationGroupementListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    associationGroupementRepository.setToken(token);
  }

  Future<AsyncValue<List<AssociationGroupement>>>
  loadAssociationGroupement() async {
    return await loadList(
      associationGroupementRepository.getAssociationGroupements,
    );
  }

  Future<bool> createAssociationGroupement(
    AssociationGroupement associationGroupement,
  ) async {
    return await add(
      associationGroupementRepository.createAssociationGroupement,
      associationGroupement,
    );
  }

  Future<bool> updateAssociationGroupement(
    AssociationGroupement associationGroupement,
  ) async {
    return await update(
      associationGroupementRepository.updateAssociationGroupement,
      (associationGroupements, associationGroupement) => associationGroupements
        ..[associationGroupements.indexWhere(
              (g) => g.id == associationGroupement.id,
            )] =
            associationGroupement,
      associationGroupement,
    );
  }

  Future<bool> deleteAssociationGroupement(
    AssociationGroupement associationGroupement,
  ) async {
    return await delete(
      associationGroupementRepository.deleteAssociationGroupement,
      (associationGroupements, associationGroupement) =>
          associationGroupements
            ..removeWhere((i) => i.id == associationGroupement.id),
      associationGroupement.id,
      associationGroupement,
    );
  }
}

final associationGroupementListProvider =
    StateNotifierProvider<
      AssociationGroupementListNotifier,
      AsyncValue<List<AssociationGroupement>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      AssociationGroupementListNotifier notifier =
          AssociationGroupementListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadAssociationGroupement();
      });
      return notifier;
    });

final groupementAdminProvider = Provider<List<AssociationGroupement>>((ref) {
  final associationGroupements = ref.watch(associationGroupementListProvider);
  final me = ref.watch(userProvider);
  return associationGroupements.maybeWhen(
    data: (groupements) {
      return groupements.where((groupement) {
        return me.groups.any(
          (userGroup) => userGroup.id == groupement.managerGroupId,
        );
      }).toList();
    },
    orElse: () => <AssociationGroupement>[],
  );
});
