import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/mypayment/class/invoice.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

String formatQuery(
  int? page,
  int? pageSize,
  List<String>? structuresIds,
  DateTime? startDate,
  DateTime? endDate,
) {
  final queryParams = <String>[];
  if (page != null) queryParams.add('page=$page');
  if (pageSize != null) queryParams.add('page_size=$pageSize');
  if (structuresIds != null) {
    for (final id in structuresIds) {
      queryParams.add('structures_ids=$id');
    }
  }
  if (startDate != null) {
    queryParams.add('start_date=${processDateToAPI(startDate)}');
  }
  if (endDate != null) {
    queryParams.add('end_date=${processDateToAPI(endDate)}');
  }
  return queryParams.isNotEmpty ? '?${queryParams.join('&')}' : '';
}

class InvoiceRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/invoices';

  Future<List<Invoice>> getInvoices(
    int page,
    int pageSize,
    List<String>? structuresIds,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    return List<Invoice>.from(
      (await getList(
        suffix: formatQuery(page, pageSize, structuresIds, startDate, endDate),
      )).map((e) => Invoice.fromJson(e)),
    );
  }

  Future<List<Invoice>> getStructureInvoices(
    String structureId,
    int page,
    int pageSize,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    return List<Invoice>.from(
      (await getList(
        suffix:
            "/structures/$structureId${formatQuery(page, pageSize, null, startDate, endDate)}",
      )).map((e) => Invoice.fromJson(e)),
    );
  }

  Future<Invoice> createInvoice(String structureId) async {
    return Invoice.fromJson(
      await create(null, suffix: "/structures/$structureId"),
    );
  }

  Future<bool> updateInvoicePaidStatus(String invoiceId, bool paid) async {
    return await update(null, "/$invoiceId/paid?paid=$paid");
  }

  Future<bool> updateInvoiceReceivedStatus(String invoiceId) async {
    return await update(null, "/$invoiceId/received");
  }

  Future<bool> deleteInvoice(String invoiceId) async {
    return await delete("/$invoiceId");
  }
}

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return InvoiceRepository()..setToken(token);
});
