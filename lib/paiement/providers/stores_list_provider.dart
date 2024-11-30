import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/repositories/stores_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class StoreListNotifier extends ListNotifier<Store> {
  final StoresRepository storesRepository;
  StoreListNotifier({required this.storesRepository})
      : super(const AsyncValue.loading());

  
  Future<AsyncValue<List<Store>>> getStores() async {
    return await loadList(storesRepository.getStores);
  }

  Future<bool> createStore(Store store) async {
    return await add(storesRepository.createStore, store);
  }

  Future<bool> updateStore(Store store) async {
    return await update(
      storesRepository.updateStore,
      (stores, store) =>
          stores..[stores.indexWhere((s) => s.id == store.id)] = store,
      store,
    );
  }

  Future<bool> deleteStore(Store store) async {
    return await delete(
      storesRepository.deleteStore,
      (stores, store) => stores..remove(store),
      store.id,
      store,
    );
  }
}

final storeListProvider =
    StateNotifierProvider<StoreListNotifier, AsyncValue<List<Store>>>((ref) {
  final storeListRepository = ref.watch(storesRepositoryProvider);
  final notifier = StoreListNotifier(storesRepository: storeListRepository)..getStores();
  return notifier;
});
