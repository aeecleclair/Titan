import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/providers/selected_interval_provider.dart';
import 'package:titan/mypayment/repositories/csv_stores_repository.dart';

class HistoryExportCsvNotifier
    extends FamilyAsyncNotifier<Uint8List, UserStore> {
  @override
  Future<Uint8List> build(UserStore store) async {
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
    AsyncNotifierProvider.family<
      HistoryExportCsvNotifier,
      Uint8List,
      UserStore
    >(HistoryExportCsvNotifier.new);
