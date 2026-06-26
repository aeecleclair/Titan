import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/mypayment/providers/last_used_store_id_provider.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';

class SelectedStoreNotifier extends Notifier<UserStore> {
  LastUsedStoreIdNotifier get lastUsedStoreIdNotifier =>
      ref.read(lastUsedStoreIdProvider.notifier);

  @override
  UserStore build() {
    final myStores = ref.watch(myStoresProvider);
    final lastUsedStoreId = ref.read(lastUsedStoreIdProvider);

    return myStores.maybeWhen<UserStore>(
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
  }

  void updateStore(UserStore store) {
    state = store;
    lastUsedStoreIdNotifier.saveLastUsedStoreIdToSharedPreferences(store.id);
  }
}

final selectedStoreProvider =
    NotifierProvider<SelectedStoreNotifier, UserStore>(
      SelectedStoreNotifier.new,
    );
