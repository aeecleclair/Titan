import 'package:flutter/foundation.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/my_payment_call_type.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/tools/functions.dart';

Checkout checkoutFromShotgun(Shotgun shotgun) {
  final redirectUrl = kIsWeb
      ? "${getTitanURL()}/payment"
      : "${getTitanURLScheme()}://payment";
  return Checkout(
    categoryId: shotgun.categories.first.id,
    sessionId: shotgun.sessions.first.id,
    answers: [],
    myPaymentRequestMethod: MyPaymentCallType.request,
    myPaymentTransferRedirectUrl: redirectUrl,
  );
}
