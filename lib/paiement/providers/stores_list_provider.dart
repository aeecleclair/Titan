import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/store.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/paiement/repositories/stores_repository.dart';
import 'package:titan/paiement/repositories/structures_repository.dart';
import 'package:titan/paiement/repositories/users_me_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class StoreListNotifier extends ListNotifier<Store> {
  final StoresRepository storesRepository;
  final StructuresRepository structureRepository;
  final UsersMeRepository usersMeRepository;
  StoreListNotifier({
    required this.storesRepository,
    required this.structureRepository,
    required this.usersMeRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<Store>>> getStores() async {
    return await loadList(
      () async => List<Store>.from(await usersMeRepository.getMyStores()),
    );
  }

  Future<bool> createStore(Structure structure, Store store) async {
    return await add(
      (_) => structureRepository.addStructureStore(structure, store),
      store,
    );
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
      final structureRepository = ref.watch(structuresRepositoryProvider);
      final usersMeRepository = ref.watch(usersMeRepositoryProvider);
      return StoreListNotifier(
        storesRepository: storeListRepository,
        structureRepository: structureRepository,
        usersMeRepository: usersMeRepository,
      )..getStores();
    });
