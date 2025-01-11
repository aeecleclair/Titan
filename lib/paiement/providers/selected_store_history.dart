import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/repositories/stores_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class SellerHistoryNotifier extends ListNotifier<History> {
  final StoresRepository storesRepository;
  SellerHistoryNotifier({required this.storesRepository})
      : super(const AsyncValue.loading());

  // Future<AsyncValue<List<History>>> getHistory(String storeId) async {
  //   return await loadList(() => storesRepository.getStoreHistory(storeId));
  // }
}

final sellerHistoryProvider =
    StateNotifierProvider<SellerHistoryNotifier, AsyncValue<List<History>>>(
        (ref) {
  final storesRepository = ref.watch(storesRepositoryProvider);
  final selectedStore = ref.watch(selectedStoreProvider);
  // if (selectedStore.id != Store.empty().id) {
  //   return SellerHistoryNotifier(storesRepository: storesRepository)
  //     ..getHistory(selectedStore.id);
  // }
  return SellerHistoryNotifier(storesRepository: storesRepository);
});
