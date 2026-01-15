import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/invoice.dart';

class InvoiceNotifier extends StateNotifier<Invoice> {
  InvoiceNotifier() : super(Invoice.empty());

  void setInvoice(Invoice invoice) {
    state = invoice;
  }

  void clearInvoice() {
    state = Invoice.empty();
  }
}
