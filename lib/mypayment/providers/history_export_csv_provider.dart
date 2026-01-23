import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/store.dart';
import 'package:titan/mypayment/providers/selected_interval_provider.dart';
import 'package:titan/mypayment/repositories/csv_stores_repository.dart';

class HistoryExportCsvNotifier extends FamilyAsyncNotifier<Uint8List, Store> {
  @override
  Future<Uint8List> build(Store store) async {
    final interval = ref.watch(selectedIntervalProvider);
    final CsvStoresRepository csvStoresRepository = ref.watch(
      csvStoresRepositoryProvider,
    );

    return await csvStoresRepository.exportStoreHistory(
      store,
      interval.start,
      interval.end,
    );
  }
}

final historyExportCsvProvider =
    AsyncNotifierProvider.family<HistoryExportCsvNotifier, Uint8List, Store>(
      HistoryExportCsvNotifier.new,
    );
