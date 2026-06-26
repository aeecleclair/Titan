import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/repositories/invoice_pdf_repository.dart';

class InvoicePdfNotifier extends AsyncNotifier<Uint8List> {
  InvoicePdfNotifier(this.invoiceId);

  final String invoiceId;

  @override
  Future<Uint8List> build() async {
    final InvoicePdfRepository invoicePdfRepository = ref.watch(
      invoicePdfRepositoryProvider,
    );
    return await invoicePdfRepository.getInvoicePdf(invoiceId);
  }
}

final invoicePdfProvider =
    AsyncNotifierProvider.family<InvoicePdfNotifier, Uint8List, String>(
      InvoicePdfNotifier.new,
    );
