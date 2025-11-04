import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/repositories/invoice_pdf_repository.dart';

class InvoicePdfNotifier extends FamilyAsyncNotifier<Uint8List, String> {
  @override
  Future<Uint8List> build(String arg) async {
    final InvoicePdfRepository invoicePdfRepository = ref.watch(
      invoicePdfRepositoryProvider,
    );
    return await invoicePdfRepository.getInvoicePdf(arg);
  }
}

final invoicePdfProvider =
    AsyncNotifierProvider.family<InvoicePdfNotifier, Uint8List, String>(
      InvoicePdfNotifier.new,
    );
