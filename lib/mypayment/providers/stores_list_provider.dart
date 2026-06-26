import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class StoreListNotifier extends ListNotifierAPI<UserStore> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<UserStore>> build() {
    getStores();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<UserStore>>> getStores() async {
    return await loadList(repository.mypaymentUsersMeStoresGet);
  }

  Future<bool> createStore(Structure structure, UserStore store) async {
    return await add(
      () => repository.mypaymentStructuresStructureIdStoresPost(
        structureId: structure.id,
        body: StoreBase(name: store.name),
      ),
      store,
    );
  }

  Future<bool> updateStore(UserStore store) async {
    return await update(
      () => repository.mypaymentStoresStoreIdPatch(
        storeId: store.id,
        body: StoreUpdate(name: store.name),
      ),
      (store) => store.id,
      store,
    );
  }

  Future<bool> deleteStore(UserStore store) async {
    return await delete(
      () => repository.mypaymentStoresStoreIdDelete(storeId: store.id),
      (store) => store.id,
      store.id,
    );
  }
}

final storeListProvider =
    NotifierProvider<StoreListNotifier, AsyncValue<List<UserStore>>>(
      StoreListNotifier.new,
    );
