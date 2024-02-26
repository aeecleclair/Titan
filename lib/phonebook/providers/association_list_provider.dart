import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/phonebook/tools/function.dart';

class AssociationListNotifier extends ListNotifier<Association> {
  final AssociationRepository associationRepository = AssociationRepository();
  AsyncValue<List<Association>> associationList = const AsyncValue.loading();
  AssociationListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    associationList = await loadList(associationRepository.getAssociationList);
    return associationList;
  }

  Future<bool> createAssociation(Association association) async {
    final result =
        await add(associationRepository.createAssociation, association);
    if (result) {
      associationList = state;
    }
    return result;
  }

  Future<bool> updateAssociation(Association association) async {
    final result = await update(
        associationRepository.updateAssociation,
        (associations, association) => associations
          ..[associations.indexWhere((g) => g.id == association.id)] =
              association,
        association);
    if (result) {
      associationList = state;
    }
    return result;
  }

  Future<bool> deleteAssociation(Association association) async {
    final result = await delete(
        associationRepository.deleteAssociation,
        (associations, association) =>
            associations..removeWhere((i) => i.id == association.id),
        association.id,
        association);
    if (result) {
      associationList = state;
    }
    return result;
  }

  void filterAssociationList(String nameFilter, String kindFilter) async {
    if (kindFilter == "") {
      associationList.maybeWhen(
        data: (data) => state = AsyncValue.data(data
            .where((element) =>
                element.name.toLowerCase().contains(nameFilter.toLowerCase()))
            .toList()),
        orElse: () => state = const AsyncLoading(),
      );
    } else {
      associationList.maybeWhen(
        data: (data) => state = AsyncValue.data(data
            .where((element) =>
                (element.name.toLowerCase().contains(nameFilter.toLowerCase()) &
                    (element.kind == kindFilter)))
            .toList()),
        orElse: () => state = const AsyncLoading(),
      );
    }
  }

  void setAssociationList(List<Association> associationList) {
    state.whenData(
      (d) {
        state = AsyncValue.data(associationList);
      },
    );
  }
}

final asyncAssociationListProvider = StateNotifierProvider<
    AssociationListNotifier, AsyncValue<List<Association>>>((ref) {
  final token = ref.watch(tokenProvider);
  AssociationListNotifier notifier = AssociationListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociations();
  });
  return notifier;
});

final associationListProvider = Provider<List<Association>>((ref) {
  final association = ref.watch(asyncAssociationListProvider);
  return association.maybeWhen(
      data: (association) => association, orElse: () => []);
});

final associationSortedListProvider = Provider<List<Association>>((ref) {
  final associationList = ref.watch(associationListProvider);
  final associationKinds = ref.watch(associationKindsProvider);
  return associationKinds.maybeWhen(
      data: (associationKinds) {
        return sortAssociation(associationList, associationKinds);
      },
      orElse: () => []);
});
