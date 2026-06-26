import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/mypayment/providers/selected_interval_provider.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SellerHistoryNotifier extends ListNotifierAPI<History> {
  Openapi get storesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<History>> build() {
    final selectedStore = ref.watch(selectedStoreProvider);
    final selectedInterval = ref.watch(selectedIntervalProvider);

    if (selectedStore.id != UserStore.empty().id) {
      getHistory(
        selectedStore.id,
        selectedInterval.start,
        selectedInterval.end,
      );
    }

    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<History>>> getHistory(
    String storeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await loadList(
      () => storesRepository.mypaymentStoresStoreIdHistoryGet(
        storeId: storeId,
        startDate: startDate.toIso8601String().split('T').first,
        endDate: endDate.toIso8601String().split('T').first,
      ),
    );
  }
}

final sellerHistoryProvider =
    NotifierProvider<SellerHistoryNotifier, AsyncValue<List<History>>>(
      SellerHistoryNotifier.new,
    );
