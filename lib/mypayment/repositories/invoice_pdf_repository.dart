import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class InvoicePdfRepository {
  final Openapi client;
  InvoicePdfRepository(this.client);

  Future<Uint8List> getInvoicePdf(String invoiceId) async {
    final response = await client.mypaymentInvoicesInvoiceIdGet(
      invoiceId: invoiceId,
    );
    return response.bodyBytes;
  }
}

final invoicePdfRepositoryProvider = Provider<InvoicePdfRepository>(
  (ref) => InvoicePdfRepository(ref.watch(repositoryProvider)),
);
