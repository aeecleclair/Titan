import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/user_store.dart';
import 'package:titan/paiement/providers/my_stores_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedStoreNotifier extends StateNotifier<UserStore> {
  SelectedStoreNotifier(super.store);

  void updateStore(UserStore store) {
    state = store;
    SharedPreferences.getInstance().then((pref) {
      pref.setString('selectedStore', store.id);
    });
  }
}

class LoadSelectedStoreIdProvider extends StateNotifier<String?> {
  LoadSelectedStoreIdProvider() : super(null);

  void loadSelectedStoreId() {
    SharedPreferences.getInstance().then((pref) {
      state = pref.getString('selectedStore');
    });
  }
}

final loadSelectedStoreIdProvider =
    StateNotifierProvider<LoadSelectedStoreIdProvider, String?>((ref) {
      LoadSelectedStoreIdProvider loadSelectedStoreIdProvider =
          LoadSelectedStoreIdProvider();
      loadSelectedStoreIdProvider.loadSelectedStoreId();
      return loadSelectedStoreIdProvider;
    });

final selectedStoreProvider =
    StateNotifierProvider<SelectedStoreNotifier, UserStore>((ref) {
      final myStores = ref.watch(myStoresProvider);
      final selectedStoreId = ref.watch(loadSelectedStoreIdProvider);
      final store = myStores.maybeWhen<UserStore>(
        orElse: () => UserStore.empty(),
        data: (value) {
          if (value.isEmpty) return UserStore.empty();
          if (selectedStoreId == null) return value.first;
          return value.firstWhere(
            (store) => store.id == selectedStoreId,
            orElse: () => value.first,
          );
        },
      );
      return SelectedStoreNotifier(store);
    });
