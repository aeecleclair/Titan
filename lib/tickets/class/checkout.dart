import 'package:titan/tickets/class/answer.dart';
import 'package:titan/tickets/class/my_payment_call_type.dart';
import 'package:titan/tools/functions.dart';

class Checkout {
  Checkout({
    required this.categoryId,
    required this.sessionId,
    required this.answers,
    required this.myPaymentRequestMethod,
    required this.myPaymentTransferRedirectUrl,
  });

  late final String categoryId;
  late final String sessionId;
  late final List<Answer> answers;
  late final MyPaymentCallType myPaymentRequestMethod;
  late final String myPaymentTransferRedirectUrl;

  // Response fields (not part of the request schema)
  late final int? price;
  late final DateTime? expiration;
  late final String? paymentUrl;

  Checkout.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] ?? '';
    sessionId = json['session_id'] ?? '';
    answers =
        (json['answers'] as List<dynamic>?)
            ?.map((e) => Answer.fromJson(e))
            .whereType<Answer>()
            .toList() ??
        [];
    myPaymentRequestMethod = json['mypayment_request_method'] != null
        ? MyPaymentCallTypeExtension.fromString(
            json['mypayment_request_method'],
          )
        : MyPaymentCallType.request;
    myPaymentTransferRedirectUrl =
        json['mypayment_transfer_redirect_url'] ?? '';

    // Response fields
    // Price is stored in cents in the backend, convert to euros for the app
    final priceInCents = (json['price'] as num?)?.toInt();
    price = priceInCents != null ? priceInCents ~/ 100 : null;
    expiration = json['expiration'] != null
        ? processDateFromAPI(json['expiration'])
        : null;
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['session_id'] = sessionId;
    data['answers'] = answers.map((e) => e.toJson()).toList();
    data['mypayment_request_method'] = myPaymentRequestMethod.value;
    data['mypayment_transfer_redirect_url'] = myPaymentTransferRedirectUrl;
    return data;
  }

  Checkout copyWith({
    String? categoryId,
    String? sessionId,
    List<Answer>? answers,
    MyPaymentCallType? myPaymentRequestMethod,
    String? myPaymentTransferRedirectUrl,
    int? price,
    DateTime? expiration,
    String? paymentUrl,
  }) {
    return Checkout(
        categoryId: categoryId ?? this.categoryId,
        sessionId: sessionId ?? this.sessionId,
        answers: answers ?? this.answers,
        myPaymentRequestMethod:
            myPaymentRequestMethod ?? this.myPaymentRequestMethod,
        myPaymentTransferRedirectUrl:
            myPaymentTransferRedirectUrl ?? this.myPaymentTransferRedirectUrl,
      )
      ..price = price ?? this.price
      ..expiration = expiration ?? this.expiration
      ..paymentUrl = paymentUrl ?? this.paymentUrl;
  }

  Checkout.empty() {
    categoryId = '';
    sessionId = '';
    answers = [];
    myPaymentRequestMethod = MyPaymentCallType.request;
    myPaymentTransferRedirectUrl = '';
    price = null;
    expiration = null;
    paymentUrl = null;
  }

  @override
  String toString() {
    return 'Checkout{categoryId: $categoryId, sessionId: $sessionId, answers: $answers, myPaymentRequestMethod: $myPaymentRequestMethod, myPaymentTransferRedirectUrl: $myPaymentTransferRedirectUrl, price: $price, expiration: $expiration, paymentUrl: $paymentUrl}';
  }
}
