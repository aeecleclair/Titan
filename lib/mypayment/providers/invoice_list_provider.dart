import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/invoice.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/repositories/invoices_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class InvoiceListNotifier extends ListNotifier<Invoice> {
  final InvoiceRepository invoicesRepository;
  InvoiceListNotifier({required this.invoicesRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Invoice>>> getInvoices({
    int page = 1,
    int pageLimit = 20,
    List<String>? structuresIds,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await loadList(
      () async => invoicesRepository.getInvoices(
        page,
        pageLimit,
        structuresIds,
        startDate,
        endDate,
      ),
    );
  }

  Future<AsyncValue<List<Invoice>>> getStructureInvoices(
    String structuresId, {
    int page = 1,
    int pageLimit = 20,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await loadList(
      () async => invoicesRepository.getStructureInvoices(
        structuresId,
        page,
        pageLimit,
        startDate,
        endDate,
      ),
    );
  }

  Future<bool> createInvoice(Structure structure) async {
    return await add(
      (_) => invoicesRepository.createInvoice(structure.id),
      Invoice.empty(),
    );
  }

  Future<bool> updateInvoicePaidStatus(Invoice invoice, bool paid) async {
    return await update(
      (_) => invoicesRepository.updateInvoicePaidStatus(invoice.id, paid),
      (invoices, invoice) =>
          invoices..[invoices.indexWhere((s) => s.id == invoice.id)] = invoice,
      invoice.copyWith(paid: paid),
    );
  }

  Future<bool> updateInvoiceReceivedStatus(Invoice invoice, bool paid) async {
    return await update(
      (_) => invoicesRepository.updateInvoiceReceivedStatus(invoice.id),
      (invoices, invoice) =>
          invoices..[invoices.indexWhere((s) => s.id == invoice.id)] = invoice,
      invoice.copyWith(received: true),
    );
  }

  Future<bool> deleteInvoice(Invoice invoice) async {
    return await delete(
      invoicesRepository.deleteInvoice,
      (invoices, invoice) => invoices..remove(invoice),
      invoice.id,
      invoice,
    );
  }
}

final invoiceListProvider =
    StateNotifierProvider<InvoiceListNotifier, AsyncValue<List<Invoice>>>((
      ref,
    ) {
      final invoicesRepository = ref.watch(invoiceRepositoryProvider);
      return InvoiceListNotifier(invoicesRepository: invoicesRepository)
        ..getInvoices();
    });
