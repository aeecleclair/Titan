import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/scan_info.dart';
import 'package:titan/mypayment/class/transaction.dart';
import 'package:titan/mypayment/repositories/stores_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class ScanNotifier extends SingleNotifier<Transaction> {
  final StoresRepository storesRepository;
  ScanNotifier({required this.storesRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Transaction>?> scan(
    String storeId,
    ScanInfo data,
  ) async {
    return await load(() => storesRepository.scan(storeId, data));
  }

  Future<bool> canScan(String storeId, ScanInfo data) async {
    return storesRepository.canScan(storeId, data);
  }

  void reset() {
    state = const AsyncValue.loading();
  }
}

final scanProvider =
    StateNotifierProvider<ScanNotifier, AsyncValue<Transaction>>((ref) {
      final storesRepository = ref.watch(storesRepositoryProvider);
      return ScanNotifier(storesRepository: storesRepository);
    });
