import 'package:flutter_riverpod/flutter_riverpod.dart';

final refundAmountProvider = NotifierProvider<RefundAmountProvider, String>(
  () => RefundAmountProvider(),
);

class RefundAmountProvider extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void setRefundAmount(String i) {
    state = i;
  }
}
