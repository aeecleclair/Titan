import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/mypayment/adapters/transaction_adapter.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ScanNotifier extends SingleNotifierAPI<History> {
  Openapi get storesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<History> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<History>?> scan(
    String storeId,
    ScanInfo data, {
    bool? bypass,
  }) async {
    return await load(() async {
      final response = await storesRepository.mypaymentStoresStoreIdScanPost(
        storeId: storeId,
        body: data.copyWith(bypassMembership: bypass),
      );
      return response.copyWith<History>(body: response.body?.toHistory());
    });
  }

  Future<bool> canScan(String storeId, ScanInfo data, {bool? bypass}) async {
    return (await storesRepository.mypaymentStoresStoreIdScanCheckPost(
          storeId: storeId,
          body: data.copyWith(bypassMembership: bypass),
        )).body?.success ??
        false;
  }

  void reset() {
    state = const AsyncValue.loading();
  }
}

final scanProvider = NotifierProvider<ScanNotifier, AsyncValue<History>>(
  ScanNotifier.new,
);
