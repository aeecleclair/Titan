import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/user_store.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';

class SelectedStoreNotifier extends StateNotifier<UserStore> {
  SelectedStoreNotifier(super.store);

  void updateStore(UserStore store) {
    state = store;
  }
}

final selectedStoreProvider =
    StateNotifierProvider<SelectedStoreNotifier, UserStore>((ref) {
      final myStores = ref.watch(myStoresProvider);
      final store = myStores.maybeWhen<UserStore>(
        orElse: () => UserStore.empty(),
        data: (value) {
          if (value.isEmpty) {
            return UserStore.empty();
          }
          return value.first;
        },
      );
      return SelectedStoreNotifier(store);
    });
