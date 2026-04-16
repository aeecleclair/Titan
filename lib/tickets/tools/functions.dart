import 'package:flutter/foundation.dart';
import 'package:titan/tickets/class/checkout.dart';
import 'package:titan/tickets/class/my_payment_call_type.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tools/functions.dart';

Checkout checkoutFromShotgun(TicketEvent ticketEvent) {
  final redirectUrl = kIsWeb
      ? "${getTitanURL()}/payment"
      : "${getTitanURLScheme()}://payment";
  return Checkout(
    categoryId: ticketEvent.categories.first.id,
    sessionId: ticketEvent.sessions.first.id,
    answers: [],
    myPaymentRequestMethod: MyPaymentCallType.request,
    myPaymentTransferRedirectUrl: redirectUrl,
  );
}
