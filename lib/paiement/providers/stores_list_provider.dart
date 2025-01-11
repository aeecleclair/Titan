import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/paiement/repositories/stores_repository.dart';
import 'package:myecl/paiement/repositories/structures_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class StoreListNotifier extends ListNotifier<Store> {
  final StoresRepository storesRepository;
  final StructuresRepository structureRepository;
  StoreListNotifier(
      {required this.storesRepository, required this.structureRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Store>>> getStores(Structure structure) async {
    return await loadList(
        () => structureRepository.getStructureStores(structure));
  }

  Future<bool> updateStore(Store store) async {
    return await update(
      storesRepository.updateStore,
      (stores, store) =>
          stores..[stores.indexWhere((s) => s.id == store.id)] = store,
      store,
    );
  }
}

final storeListProvider =
    StateNotifierProvider<StoreListNotifier, AsyncValue<List<Store>>>((ref) {
  final storeListRepository = ref.watch(storesRepositoryProvider);
  final structureRepository = ref.watch(structuresRepositoryProvider);
  final notifier = StoreListNotifier(
      storesRepository: storeListRepository,
      structureRepository: structureRepository);
  return notifier;
});
