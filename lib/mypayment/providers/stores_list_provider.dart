import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/mypayment/class/store.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/repositories/stores_repository.dart';
import 'package:titan/mypayment/repositories/structures_repository.dart';
import 'package:titan/mypayment/repositories/users_me_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class StoreListNotifier extends ListNotifier<Store> {
  final StoresRepository storesRepository;
  final StructuresRepository structureRepository;
  final UsersMeRepository usersMeRepository;
  final List<Association> associations;
  StoreListNotifier({
    required this.storesRepository,
    required this.structureRepository,
    required this.usersMeRepository,
    required this.associations,
  }) : super(const AsyncValue.loading());

  Store _toStore(UserStore us) {
    return Store(
      id: us.id,
      name: us.name,
      walletId: us.walletId,
      structure: us.structure,
      association: us.associationId == null
          ? Association.empty()
          : associations.firstWhere(
              (a) => a.id == us.associationId,
              orElse: () => Association.empty(),
            ),
    );
  }

  Future<AsyncValue<List<Store>>> getStores() async {
    return await loadList(
      () async =>
          (await usersMeRepository.getMyStores()).map(_toStore).toList(),
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
      final associations =
          ref.watch(associationListProvider).asData?.value ?? const [];
      return StoreListNotifier(
        storesRepository: storeListRepository,
        structureRepository: structureRepository,
        usersMeRepository: usersMeRepository,
        associations: associations,
      )..getStores();
    });
