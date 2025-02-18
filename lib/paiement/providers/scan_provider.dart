import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/qr_code_data.dart';
import 'package:myecl/paiement/class/transaction.dart';
import 'package:myecl/paiement/repositories/stores_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class ScanNotifier extends SingleNotifier<Transaction> {
  final StoresRepository storesRepository;
  ScanNotifier({required this.storesRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<Transaction>> scan(String storeId, QrCodeData data,
      {bool? bypass}) async {
    return await load(
      () => storesRepository.scan(
        storeId,
        data,
        bypass,
      ),
    );
  }
}

final scanProvider =
    StateNotifierProvider<ScanNotifier, AsyncValue<Transaction>>((ref) {
  final storesRepository = ref.watch(storesRepositoryProvider);
  return ScanNotifier(storesRepository: storesRepository);
});
