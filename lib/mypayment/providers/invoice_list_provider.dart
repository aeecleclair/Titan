import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class InvoiceListNotifier extends ListNotifierAPI<Invoice> {
  Openapi get invoicesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Invoice>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Invoice>>> getInvoices({
    int page = 1,
    int pageLimit = 20,
    List<String>? structuresIds,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await loadList(
      () async => invoicesRepository.mypaymentInvoicesGet(
        page: page,
        pageSize: pageLimit,
        structuresIds: structuresIds,
        startDate: startDate?.toIso8601String().split('T').first,
        endDate: endDate?.toIso8601String().split('T').first,
      ),
    );
  }

  Future<AsyncValue<List<Invoice>>> getStructureInvoices(
    String structureId, {
    int page = 1,
    int pageLimit = 20,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await loadList(
      () async => invoicesRepository.mypaymentInvoicesStructuresStructureIdGet(
        structureId: structureId,
        page: page,
        pageSize: pageLimit,
        startDate: startDate?.toIso8601String().split('T').first,
        endDate: endDate?.toIso8601String().split('T').first,
      ),
    );
  }

  Future<bool> createInvoice(Structure structure) async {
    return await add(
      () => invoicesRepository.mypaymentInvoicesStructuresStructureIdPost(
        structureId: structure.id,
      ),
      Invoice.empty(),
    );
  }

  Future<bool> updateInvoicePaidStatus(Invoice invoice, bool paid) async {
    return await update(
      () => invoicesRepository.mypaymentInvoicesInvoiceIdPaidPatch(
        invoiceId: invoice.id,
        paid: paid,
      ),
      (invoice) => invoice.id,
      invoice.copyWith(paid: paid),
    );
  }

  Future<bool> updateInvoiceReceivedStatus(Invoice invoice, bool paid) async {
    return await update(
      () => invoicesRepository.mypaymentInvoicesInvoiceIdReceivedPatch(
        invoiceId: invoice.id,
      ),
      (invoice) => invoice.id,
      invoice.copyWith(received: true),
    );
  }

  Future<bool> deleteInvoice(Invoice invoice) async {
    return await delete(
      () => invoicesRepository.mypaymentInvoicesInvoiceIdDelete(
        invoiceId: invoice.id,
      ),
      (invoice) => invoice.id,
      invoice.id,
    );
  }
}

final invoiceListProvider =
    NotifierProvider<InvoiceListNotifier, AsyncValue<List<Invoice>>>(
      InvoiceListNotifier.new,
    );
