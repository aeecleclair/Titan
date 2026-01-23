import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/mypayment/class/history.dart';
import 'package:titan/mypayment/class/qr_code_data.dart';
import 'package:titan/mypayment/class/store.dart';
import 'package:titan/mypayment/class/transaction.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class StoresRepository extends Repository {
  @override
  // ignore: overridden_fields
  final String ext = 'mypayment/stores';

  Future<bool> updateStore(Store store) async {
    return await update(store.toJson(), "/${store.id}");
  }

  Future<bool> deleteStore(String id) async {
    return await delete("/$id");
  }

  Future<List<History>> getStoreHistory(
    String id,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final queryParams = {
      'start_date': processDateToAPI(startDate),
      'end_date': processDateToAPI(endDate),
    };

    final queryString = Uri(queryParameters: queryParams).query;
    final url = "/$id/history?$queryString";

    return List<History>.from(
      (await getList(suffix: url)).map((e) => History.fromJson(e)),
    );
  }

  Future<void> exportStoreHistory(
    Store store,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final queryParams = {
      'start_date': processDateToAPI(startDate),
      'end_date': processDateToAPI(endDate),
    };

    final queryString = Uri(queryParameters: queryParams).query;
    final url = "/$store.id/history/data-export?$queryString";

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final String fileName = "Store_history_${store.name}";

        await FileSaver.instance.saveFile(
          name: fileName.replaceAll('.csv', ''),
          bytes: bytes,
          ext: 'csv',
          mimeType: MimeType.csv,
        );
      }
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }

  Future<Transaction> scan(String id, QrCodeData data, bool? bypass) async {
    return Transaction.fromJson(
      await create({
        ...data.toJson(),
        "bypass_membership": bypass ?? false,
      }, suffix: "/$id/scan"),
    );
  }

  Future<bool> canScan(String id, QrCodeData data, bool? bypass) async {
    final response = await create({
      ...data.toJson(),
      "bypass_membership": bypass ?? false,
    }, suffix: "/$id/scan/check");
    return response["success"] == true;
  }
}

final storesRepositoryProvider = Provider<StoresRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return StoresRepository()..setToken(token);
});
