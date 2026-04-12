import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/pdf_repository.dart';

class InvoicePdfRepository extends PdfRepository {
  @override
  // ignore: overridden_fields
  final ext = "mypayment/invoices/";

  Future<Uint8List> getInvoicePdf(String invoiceId) async {
    return await getPdf(invoiceId);
  }
}

final invoicePdfRepositoryProvider = Provider<InvoicePdfRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return InvoicePdfRepository()..setToken(token);
});
