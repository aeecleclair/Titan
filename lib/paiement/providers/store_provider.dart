import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myemapp/paiement/class/store.dart';

class StoreProvider extends StateNotifier<Store> {
  StoreProvider() : super(Store.empty());

  void updateStore(Store store) {
    state = store;
  }
}

final storeProvider = StateNotifierProvider<StoreProvider, Store>((ref) {
  return StoreProvider();
});
