import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssociationListNotifier extends StateNotifier<AsyncValue<List<String>>> {
  AssociationListNotifier() : super(const AsyncValue.loading());

  //TODO: tous les faire

  Future<AsyncValue<List<String>>> loadHistory() async {
    try {
      // final loans = await _repository.getHistory();
      final loans = [
        "Asso 1",
        "Asso 2",
        "Asso 3",
      ];
      state = AsyncValue.data(loans);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }
}

final associationListProvider =
    StateNotifierProvider<AssociationListNotifier, AsyncValue<List<String>>>((ref) {
  AssociationListNotifier _associationListNotifier = AssociationListNotifier();
  _associationListNotifier.loadHistory();
  return _associationListNotifier;
});
