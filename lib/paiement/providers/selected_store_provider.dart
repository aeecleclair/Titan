import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';

class SelectedStoreNotifier extends StateNotifier<Store> {
  SelectedStoreNotifier(super.store);

  void updateStore(Store store) {
    state = store;
  }
}

final selectedStoreProvider =
    StateNotifierProvider<SelectedStoreNotifier, Store>((ref) {
  final myStores = ref.watch(myStoresProvider);
  final store = myStores.maybeWhen<Store>(
    orElse: () => Store.empty(),
    data: (value) {
      if (value.isEmpty) {
        return Store.empty();
      }
      return value.first;
    },
  );
  return SelectedStoreNotifier(store);
});
