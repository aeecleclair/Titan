import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/qr_code_data.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/class/transaction.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/repository/repository.dart';

class StoresRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  StoresRepository(super.ref);

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
