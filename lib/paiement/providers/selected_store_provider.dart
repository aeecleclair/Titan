import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/user_store.dart';
import 'package:titan/paiement/providers/last_used_store_id_provider.dart';
import 'package:titan/paiement/providers/my_stores_provider.dart';

class SelectedStoreNotifier extends StateNotifier<UserStore> {
  final LastUsedStoreIdNotifier lastUsedStoreIdNotifier;
  SelectedStoreNotifier(this.lastUsedStoreIdNotifier, super.store);

  void updateStore(UserStore store) {
    state = store;
    lastUsedStoreIdNotifier.saveLastUsedStoreIdToSharedPreferences(store.id);
  }
}

final selectedStoreProvider =
    StateNotifierProvider<SelectedStoreNotifier, UserStore>((ref) {
      final myStores = ref.watch(myStoresProvider);
      final lastUsedStoreId = ref.read(lastUsedStoreIdProvider);
      final lastUsedStoreIdNotifier = ref.read(lastUsedStoreIdProvider.notifier);
      final store = myStores.maybeWhen<UserStore>(
        orElse: () => UserStore.empty(),
        data: (value) {
          if (value.isEmpty) {
            return UserStore.empty();
          }
          return value.firstWhere(
            (store) => store.id == lastUsedStoreId,
            orElse: () => value.first,
          );
        },
      );
      return SelectedStoreNotifier(lastUsedStoreIdNotifier, store);
    });
