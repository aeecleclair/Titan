import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class InvoicePdfNotifier extends AsyncNotifier<Uint8List> {
  InvoicePdfNotifier(this.invoiceId);

  final String invoiceId;

  Openapi get repository => ref.watch(repositoryProvider);

  @override
  Future<Uint8List> build() async {
    final response = await repository.mypaymentInvoicesInvoiceIdGet(
      invoiceId: invoiceId,
    );
    return response.bodyBytes;
  }
}

final invoicePdfProvider =
    AsyncNotifierProvider.family<InvoicePdfNotifier, Uint8List, String>(
      InvoicePdfNotifier.new,
    );
