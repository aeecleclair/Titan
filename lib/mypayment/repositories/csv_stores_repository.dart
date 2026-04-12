import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/mypayment/class/store.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/csv_repository.dart';

class CsvStoresRepository extends CsvRepository {
  @override
  //ignore: overridden_fields
  final ext = "mypayment/stores/";

  Future<Uint8List> exportStoreHistory(
    Store store,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final queryParams = {
      'start_date': processDateToAPI(startDate),
      'end_date': processDateToAPI(endDate),
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return await getCsv(store.id, suffix: "/history/data-export?$queryString");
  }
}

final csvStoresRepositoryProvider = Provider<CsvStoresRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CsvStoresRepository()..setToken(token);
});
