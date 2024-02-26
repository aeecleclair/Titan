import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationListNotifier extends ListNotifier<Association> {
  final AssociationRepository associationRepository = AssociationRepository();
  AssociationListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }

  late List<Association> associationList;

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    associationList = await associationRepository.getAssociationList();
    return await loadList(() async => associationRepository.getAssociationList());
  }

  List<Association> filterAssociations(String filter) {
    if (filter.isEmpty) {
      return associationList;
    }
    return associationList
        .where((association) =>
            association.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

//  Future<AsyncValue<List<Association>>> loadAssociationsFromUser(User user) async {
//    return await loadList(() async {
//      return user.associations;
//    });
//  }

  Future<bool> createAssociation(Association association) async {
    return await add(associationRepository.createAssociation, association);
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(
        associationRepository.updateAssociation,
        (associations, association) =>
            associations..[associations.indexWhere((g) => g.id == association.id)] = association,
        association);
  }

  Future<bool> deleteAssociation(Association association) async {
    return await delete(
        associationRepository.deleteAssociation,
        (associations, association) => associations..removeWhere((i) => i.id == association.id),
        association.id,
        association);
  }

  void setAssociationList(List<Association> associationList) {
    state.whenData(
      (d) {
        state =
            AsyncValue.data(associationList);
      },
    );
  }
}

final associationListProvider =
    StateNotifierProvider<AssociationListNotifier, AsyncValue<List<Association>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  AssociationListNotifier notifier = AssociationListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociations();
  });
  return notifier;
});

//final userAssociationListNotifier =
//    StateNotifierProvider<AssociationListNotifier, AsyncValue<List<Association>>>(
//        (ref) {
//  final token = ref.watch(tokenProvider);
//  AssociationListNotifier provider = AssociationListNotifier(token: token);
//  tokenExpireWrapperAuth(ref, () async {
//    await provider.loadAssociationsFromUser(ref.watch(userProvider));
//  });
//  return provider;
//});
